import 'dart:convert';

import 'package:flyful_farms/core/api/endpoints.dart';
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
  final SyncStorage _storage;
  final ApiPost upload;
  final ApiGet fetch;
  final Uuid _uuid = const Uuid();

  static const _deviceIdKey = 'sync_device_id';
  static const _farmIdKey = 'sync_farm_id';

  SyncService(
    this._syncDao,
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

      if (op.entityType == 'batch' && farm != null) {
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
}