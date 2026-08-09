import 'package:flutter/foundation.dart';
import 'package:flyful_farms/core/database/app_database.dart';
import 'package:flyful_farms/core/database/daos/download_dao.dart';
import 'package:flyful_farms/core/database/daos/sync_dao.dart';
import 'package:uuid/uuid.dart';
import 'package:drift/drift.dart' as drift;
import 'dart:convert';

class RecordProvider extends ChangeNotifier {
  final DownloadDao _downloadDao;
  final SyncDao _syncDao;
  final Uuid _uuid = const Uuid();

  List<Feeding> _feedings = [];
  List<Harvest> _harvests = [];
  List<EggCollection> _eggCollections = [];
  List<CageMaintenance> _maintenances = [];
  bool _loading = false;

  RecordProvider(this._downloadDao, this._syncDao);

  List<Feeding> get feedings => List.unmodifiable(_feedings);
  List<Harvest> get harvests => List.unmodifiable(_harvests);
  List<EggCollection> get eggCollections => List.unmodifiable(_eggCollections);
  List<CageMaintenance> get maintenances => List.unmodifiable(_maintenances);
  bool get loading => _loading;

  Future<void> loadBatchRecords(String batchId) async {
    _loading = true;
    notifyListeners();
    try {
      _feedings = await _downloadDao.feedingsForBatch(batchId);
      _harvests = await _downloadDao.harvestsForBatch(batchId);
    } catch (_) {
      _feedings = [];
      _harvests = [];
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> loadCageRecords(String cageId) async {
    _loading = true;
    notifyListeners();
    try {
      _eggCollections = await _downloadDao.eggCollectionsForCage(cageId);
      _maintenances = await _downloadDao.maintenancesForCage(cageId);
    } catch (_) {
      _eggCollections = [];
      _maintenances = [];
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> deleteFeeding(Feeding feeding) async {
    await _delete('feeding', feeding.remoteId, () => _downloadDao.deleteFeeding(feeding.id));
    await loadBatchRecords(feeding.batchId);
  }

  Future<void> deleteHarvest(Harvest harvest) async {
    await _delete('harvest', harvest.remoteId, () => _downloadDao.deleteHarvest(harvest.id));
    await loadBatchRecords(harvest.batchId);
  }

  Future<void> deleteEggCollection(EggCollection egg) async {
    await _delete('egg_collection', egg.remoteId, () => _downloadDao.deleteEggCollection(egg.id));
    await loadCageRecords(egg.cageId);
  }

  Future<void> deleteMaintenance(CageMaintenance maintenance) async {
    await _delete('cage_maintenance', maintenance.remoteId, () => _downloadDao.deleteMaintenance(maintenance.id));
    await loadCageRecords(maintenance.cageId);
  }

  Future<void> _delete(
    String entityType,
    String? remoteId,
    Future<int> Function() removeLocal,
  ) async {
    if (remoteId != null && remoteId.isNotEmpty) {
      await _syncDao.insertSyncOperation(
        SyncOutboxesCompanion.insert(
          operationId: _uuid.v4(),
          entityType: entityType,
          entityId: drift.Value(remoteId),
          operation: drift.Value('delete'),
          payload: drift.Value(jsonEncode({})),
        ),
      );
    }
    await removeLocal();
  }
}