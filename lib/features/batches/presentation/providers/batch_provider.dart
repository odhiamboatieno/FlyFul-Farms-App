import 'package:flutter/foundation.dart';
import 'package:flyful_farms/core/database/app_database.dart';
import 'package:flyful_farms/core/database/daos/batch_dao.dart';
import 'package:flyful_farms/core/database/daos/sync_dao.dart';
import 'package:uuid/uuid.dart';
import 'package:drift/drift.dart' as drift;
import 'dart:convert';

class BatchProvider extends ChangeNotifier {
  final BatchDao _batchDao;
  final SyncDao _syncDao;
  final Uuid _uuid = const Uuid();

  BatchProvider(this._batchDao, this._syncDao);

  List<Batche> _batches = [];
  bool _loading = false;
  String? _error;

  List<Batche> get batches => List.unmodifiable(_batches);
  bool get loading => _loading;
  String? get error => _error;

  Future<void> loadBatches() async {
    _loading = true;
    _error = null;
    notifyListeners();
    try {
      _batches = await _batchDao.getAllBatches();
    } catch (e) {
      _error = 'Could not load batches.';
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Batche? batchById(int id) {
    for (final b in _batches) {
      if (b.id == id) return b;
    }
    return null;
  }

  Future<void> createBatch({
    required String batchNumber,
    required String wasteType,
    required double wasteQuantityKg,
    int neonatesAdded = 0,
    String? startDate,
    String? expectedHarvestDate,
    String? notes,
    String? farmerName,
  }) async {
    final now = DateTime.now();
    final remoteId = _uuid.v4();
    final companion = BatchesCompanion.insert(
      remoteId: drift.Value(remoteId),
      batchNumber: drift.Value(batchNumber),
      wasteType: drift.Value(wasteType),
      wasteQuantityKg: drift.Value(wasteQuantityKg),
      neonatesAdded: drift.Value(neonatesAdded),
      status: drift.Value('active'),
      dayNumber: drift.Value(0),
      startDate: startDate ?? now.toIso8601String(),
      expectedHarvestDate: expectedHarvestDate ?? '',
      notes: drift.Value(notes),
      farmerName: drift.Value(farmerName ?? ''),
      createdAt: drift.Value(now),
      updatedAt: drift.Value(now),
    );

    await _batchDao.insertBatch(companion);

    await _syncDao.insertSyncOperation(
      SyncOutboxesCompanion.insert(
        operationId: _uuid.v4(),
        entityType: 'batch',
        entityId: drift.Value(remoteId),
        operation: drift.Value('create'),
        payload: drift.Value(
          jsonEncode(_batchToJson(companion)),
        ),
      ),
    );

    await loadBatches();
  }

  Future<void> deleteBatch(int id) async {
    final batch = batchById(id);
    if (batch == null) return;

    if (batch.remoteId != null && batch.remoteId!.isNotEmpty) {
      await _syncDao.insertSyncOperation(
        SyncOutboxesCompanion.insert(
          operationId: _uuid.v4(),
          entityType: 'batch',
          entityId: drift.Value(batch.remoteId),
          operation: drift.Value('delete'),
          payload: drift.Value('{}'),
        ),
      );
    }

    await _batchDao.deleteBatch(id);
    await loadBatches();
  }

  Map<String, dynamic> _batchToJson(BatchesCompanion b) {
    return {
      'batchNumber': b.batchNumber.value,
      'wasteType': b.wasteType.value,
      'wasteQuantityKg': b.wasteQuantityKg.value,
      'neonatesAdded': b.neonatesAdded.value,
      'status': b.status.value,
      'dayNumber': b.dayNumber.value,
      'startDate': b.startDate.value,
      'expectedHarvestDate': b.expectedHarvestDate.value,
      'notes': b.notes.value,
      'farmerName': b.farmerName.value,
    };
  }
}
