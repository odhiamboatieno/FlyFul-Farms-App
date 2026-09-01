import 'dart:convert';

import 'package:flyful_farms/core/api/endpoints.dart';
import 'package:flyful_farms/core/database/app_database.dart';
import 'package:flyful_farms/core/database/daos/download_dao.dart';
import 'package:flyful_farms/core/database/daos/sync_dao.dart';
import 'package:uuid/uuid.dart';

typedef ApiGet = Future<Map<String, dynamic>> Function(
  String path, {
  Map<String, dynamic>? queryParameters,
});

typedef ApiPost = Future<Map<String, dynamic>> Function(
  String path,
  Map<String, dynamic> data,
);

abstract class SyncStorage {
  Future<String?> read(String key);
  Future<void> write(String key, String value);
}

class SyncResult {
  final int processed;
  final int failed;
  final int conflicts;

  const SyncResult({
    this.processed = 0,
    this.failed = 0,
    this.conflicts = 0,
  });
}

class SyncService {
  final SyncDao _syncDao;
  final DownloadDao _downloadDao;
  final SyncStorage _storage;
  final ApiPost upload;
  final ApiGet fetch;
  final Uuid _uuid = const Uuid();

  static const _deviceIdKey = 'sync_device_id';
  static const _farmIdKey = 'sync_farm_id';
  static const _lastDownloadKey = 'sync_last_download';

  SyncService(
    this._syncDao,
    this._downloadDao,
    this._storage, {
    required ApiPost post,
    required ApiGet get,
  })  : upload = post,
        fetch = get;

  Future<String> deviceId() async {
    final existing = await _storage.read(_deviceIdKey);
    if (existing != null && existing.isNotEmpty) {
      return existing;
    }
    final id = _uuid.v4();
    await _storage.write(_deviceIdKey, id);
    return id;
  }

  Future<String?> farmId() async {
    final cached = await _storage.read(_farmIdKey);
    if (cached != null && cached.isNotEmpty) {
      return cached;
    }
    try {
      final response = await fetch(ApiEndpoints.farms);
      final data = response['data'];
      if (data is List && data.isNotEmpty) {
        final first = data.first as Map<String, dynamic>;
        final id = first['id']?.toString();
        if (id != null && id.isNotEmpty) {
          await _storage.write(_farmIdKey, id);
          return id;
        }
      }
    } catch (_) {}
    return null;
  }

  /// Forget the cached farm when the account changes, so a new sign-in does
  /// not sync into the previous user's farm.
  Future<void> clearFarmId() async {
    await _storage.write(_farmIdKey, '');
  }

  Future<SyncResult> syncNow() async {
    final pending = await _syncDao.getPendingOperations();
    if (pending.isEmpty) {
      return const SyncResult();
    }

    final farm = await farmId();
    final device = await deviceId();

    final operations = <Map<String, dynamic>>[];
    for (final op in pending) {
      Map<String, dynamic> payload;
      try {
        payload = jsonDecode(op.payload) as Map<String, dynamic>;
      } catch (_) {
        payload = <String, dynamic>{};
      }

      if (op.entityType == 'batch' || op.entityType == 'breeding_cage') {
        if (farm == null) {
          // Batches and cages require a farm on the server. Without one the
          // create would 500 on a foreign-key constraint, so leave the op
          // pending and retry once a farm is available.
          continue;
        }
        payload['farmId'] = farm;
      }

      operations.add({
        'operationId': op.operationId,
        'entityType': op.entityType,
        'entityId': op.entityId ?? op.operationId,
        'operation': op.operation,
        'aggregateVersion': 1,
        'payload': payload,
        'occurredAt': op.createdAt.toIso8601String(),
      });
    }

    if (operations.isEmpty) {
      return const SyncResult();
    }

    final response = await upload(
      ApiEndpoints.syncUpload,
      {'deviceId': device, 'operations': operations},
    );

    final data = response['data'] as Map<String, dynamic>? ?? {};
    final results = data['results'] as List? ?? [];
    final conflictCount = (data['conflictCount'] as num?)?.toInt() ?? 0;

    var processed = 0;
    var failed = 0;

    for (final result in results) {
      final item = result as Map<String, dynamic>;
      final operationId = item['operationId']?.toString();
      final status = item['status']?.toString() ?? 'error';

      final op = operationId == null
          ? null
          : await _syncDao.findPendingByOperationId(operationId);
      if (op == null) {
        continue;
      }

      if (status == 'success' || status == 'already_processed') {
        await _syncDao.markAsComplete(op.id);
        processed++;
      } else {
        await _syncDao.markAsFailed(op.id, error: 'Server status: $status');
        failed++;
      }
    }

    return SyncResult(processed: processed, failed: failed, conflicts: conflictCount);
  }

  Future<int> syncDownload() async {
    final since = await _storage.read(_lastDownloadKey) ??
        DateTime.fromMillisecondsSinceEpoch(0, isUtc: true).toIso8601String();

    final response = await fetch(
      ApiEndpoints.syncDownload,
      queryParameters: {'since': since},
    );

    final data = response['data'] as Map<String, dynamic>? ?? {};
    final changes = data['changes'] as List? ?? [];
    final newSince = data['since']?.toString();

    var applied = 0;
    for (final change in changes) {
      final item = change as Map<String, dynamic>;
      final entityType = item['entityType']?.toString();
      final payload = item['payload'] as Map<String, dynamic>? ?? {};
      final remoteId = payload['id']?.toString();
      final operation = item['operation']?.toString() ?? 'create';

      if (remoteId == null || remoteId.isEmpty) continue;

      if (operation == 'delete') {
        final removed = switch (entityType) {
          'batch' => await _deleteBatchByRemoteId(remoteId),
          'breeding_cage' => await _deleteCageByRemoteId(remoteId),
          'feeding' => await _deleteFeedingByRemoteId(remoteId),
          'harvest' => await _deleteHarvestByRemoteId(remoteId),
          'egg_collection' => await _deleteEggCollectionByRemoteId(remoteId),
          'cage_maintenance' => await _deleteMaintenanceByRemoteId(remoteId),
          _ => false,
        };
        if (removed) applied++;
        continue;
      }

      final handled = switch (entityType) {
        'batch' => await _upsertBatch(remoteId, payload),
        'breeding_cage' => await _upsertBreedingCage(remoteId, payload),
        'feeding' => await _upsertFeeding(remoteId, payload),
        'harvest' => await _upsertHarvest(remoteId, payload),
        'egg_collection' => await _upsertEggCollection(remoteId, payload),
        'cage_maintenance' => await _upsertCageMaintenance(remoteId, payload),
        _ => false,
      };
      if (handled) applied++;
    }

    if (newSince != null && newSince.isNotEmpty) {
      await _storage.write(_lastDownloadKey, newSince);
    }

    return applied;
  }

  /// Fetch unresolved sync conflicts from the server.
  Future<List<Map<String, dynamic>>> fetchConflicts() async {
    try {
      final response = await fetch(ApiEndpoints.syncConflicts);
      final data = response['data'];
      if (data is List) {
        return data.cast<Map<String, dynamic>>();
      }
    } catch (_) {}
    return [];
  }

  /// Resolve a sync conflict. `resolution` is 'client_wins' or 'server_wins'.
  Future<bool> resolveConflict(String conflictId, String resolution) async {
    try {
      final path = '${ApiEndpoints.syncConflicts}/$conflictId/resolve';
      await upload(path, {'resolution': resolution});
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<bool> _deleteBatchByRemoteId(String remoteId) async {
    final id = await _downloadDao.batchIdByRemoteId(remoteId);
    if (id == null) return false;
    await _downloadDao.deleteBatch(id);
    return true;
  }

  Future<bool> _deleteCageByRemoteId(String remoteId) async {
    final id = await _downloadDao.cageIdByRemoteId(remoteId);
    if (id == null) return false;
    await _downloadDao.deleteCage(id);
    return true;
  }

  Future<bool> _deleteFeedingByRemoteId(String remoteId) async {
    final id = await _downloadDao.feedingIdByRemoteId(remoteId);
    if (id == null) return false;
    await _downloadDao.deleteFeeding(id);
    return true;
  }

  Future<bool> _deleteHarvestByRemoteId(String remoteId) async {
    final id = await _downloadDao.harvestIdByRemoteId(remoteId);
    if (id == null) return false;
    await _downloadDao.deleteHarvest(id);
    return true;
  }

  Future<bool> _deleteEggCollectionByRemoteId(String remoteId) async {
    final id = await _downloadDao.eggCollectionIdByRemoteId(remoteId);
    if (id == null) return false;
    await _downloadDao.deleteEggCollection(id);
    return true;
  }

  Future<bool> _deleteMaintenanceByRemoteId(String remoteId) async {
    final id = await _downloadDao.maintenanceIdByRemoteId(remoteId);
    if (id == null) return false;
    await _downloadDao.deleteMaintenance(id);
    return true;
  }

  Future<bool> _upsertBatch(String remoteId, Map<String, dynamic> p) async {
    final updatedAt = DateTime.tryParse(p['updatedAt']?.toString() ?? '') ?? DateTime.now();
    final startDate = p['startDate']?.toString() ?? updatedAt.toIso8601String();
    await _downloadDao.upsertBatch(Batche(
      id: 0,
      remoteId: remoteId,
      batchNumber: p['batchNumber']?.toString() ?? '',
      farmerId: p['farmId']?.toString() ?? '',
      farmerName: '',
      wasteType: p['wasteType']?.toString() ?? 'mixed_waste',
      wasteQuantityKg: double.tryParse(p['wasteQuantityKg']?.toString() ?? '') ?? 0,
      neonatesAdded: int.tryParse(p['neonatesAdded']?.toString() ?? '') ?? 0,
      status: p['status']?.toString() ?? 'active',
      dayNumber: int.tryParse(p['dayNumber']?.toString() ?? '') ?? 0,
      startDate: startDate,
      expectedHarvestDate: p['expectedHarvestDate']?.toString() ?? '',
      actualHarvestDate: p['actualHarvestDate']?.toString(),
      notes: p['notes']?.toString(),
      photoUrl: p['photoUrl']?.toString(),
      latitude: double.tryParse(p['latitude']?.toString() ?? ''),
      longitude: double.tryParse(p['longitude']?.toString() ?? ''),
      createdAt: updatedAt,
      updatedAt: updatedAt,
    ));
    return true;
  }

  Future<bool> _upsertBreedingCage(String remoteId, Map<String, dynamic> p) async {
    final updatedAt = DateTime.tryParse(p['updatedAt']?.toString() ?? '') ?? DateTime.now();
    await _downloadDao.upsertBreedingCage(BreedingCage(
      id: 0,
      remoteId: remoteId,
      cageNumber: p['cageNumber']?.toString() ?? '',
      farmerId: p['farmId']?.toString() ?? '',
      status: p['status']?.toString() ?? 'active',
      ageDays: int.tryParse(p['ageDays']?.toString() ?? '') ?? 0,
      pupaLoadedKg: double.tryParse(p['pupaLoadedKg']?.toString() ?? '') ?? 0,
      pupaSource: p['pupaSource']?.toString(),
      breedingDate: DateTime.tryParse(p['breedingDate']?.toString() ?? ''),
      lastMaintenanceDate: DateTime.tryParse(p['lastMaintenanceDate']?.toString() ?? ''),
      attractantInstalled: p['attractantInstalled'] == true,
      waterAdded: p['waterAdded'] == true,
      notes: p['notes']?.toString(),
      createdAt: updatedAt,
      updatedAt: updatedAt,
    ));
    return true;
  }

  Future<bool> _upsertFeeding(String remoteId, Map<String, dynamic> p) async {
    final fedAt = DateTime.tryParse(p['occurredAt']?.toString() ?? '') ?? DateTime.now();
    final weight = double.tryParse(p['wasteQuantityKg']?.toString() ?? '');
    if (weight == null) return false;
    await _downloadDao.upsertFeeding(Feeding(
      id: 0,
      remoteId: remoteId,
      batchId: p['batchId']?.toString() ?? '',
      wasteQuantityKg: weight,
      wasteType: p['wasteType']?.toString() ?? '',
      fedAt: fedAt,
      notes: p['notes']?.toString(),
      photoUrl: null,
      createdAt: fedAt,
      updatedAt: fedAt,
    ));
    return true;
  }

  Future<bool> _upsertHarvest(String remoteId, Map<String, dynamic> p) async {
    final harvestedAt =
        DateTime.tryParse(p['harvestDate']?.toString() ?? '') ?? DateTime.now();
    final wetLarvae = double.tryParse(p['wetLarvaeKg']?.toString() ?? '');
    if (wetLarvae == null) return false;
    await _downloadDao.upsertHarvest(Harvest(
      id: 0,
      remoteId: remoteId,
      batchId: p['batchId']?.toString() ?? '',
      wetLarvaeKg: wetLarvae,
      frassKg: double.tryParse(p['frassKg']?.toString() ?? ''),
      pupaKg: double.tryParse(p['pupaKg']?.toString() ?? ''),
      harvestedAt: harvestedAt,
      notes: p['notes']?.toString(),
      photoUrl: p['photoUrl']?.toString(),
      createdAt: harvestedAt,
      updatedAt: harvestedAt,
    ));
    return true;
  }

  Future<bool> _upsertEggCollection(String remoteId, Map<String, dynamic> p) async {
    final collectedAt =
        DateTime.tryParse(p['collectionDate']?.toString() ?? '') ?? DateTime.now();
    await _downloadDao.upsertEggCollection(EggCollection(
      id: 0,
      remoteId: remoteId,
      cageId: p['cageId']?.toString() ?? '',
      eggWeightGrams: p['eggWeightGrams']?.toString() ?? '',
      quality: p['quality']?.toString() ?? 'good',
      collectedAt: collectedAt,
      notes: p['notes']?.toString(),
      photoUrl: p['photoUrl']?.toString(),
      createdAt: collectedAt,
      updatedAt: collectedAt,
    ));
    return true;
  }

  Future<bool> _upsertCageMaintenance(String remoteId, Map<String, dynamic> p) async {
    final maintenanceDate =
        DateTime.tryParse(p['date']?.toString() ?? '') ?? DateTime.now();
    await _downloadDao.upsertCageMaintenance(CageMaintenance(
      id: 0,
      remoteId: remoteId,
      cageId: p['cageId']?.toString() ?? '',
      maintenanceDate: maintenanceDate,
      waterChanged: p['waterChanged'] == true,
      attractantReplaced: p['attractantReplaced'] == true,
      cleaningDone: p['cleaningDone'] == true,
      notes: p['notes']?.toString(),
      createdAt: maintenanceDate,
      updatedAt: maintenanceDate,
    ));
    return true;
  }
}