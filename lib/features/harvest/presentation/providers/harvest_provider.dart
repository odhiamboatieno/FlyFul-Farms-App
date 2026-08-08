import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flyful_farms/core/database/app_database.dart';
import 'package:flyful_farms/core/database/daos/download_dao.dart';
import 'package:flyful_farms/core/database/daos/sync_dao.dart';
import 'package:drift/drift.dart' as drift;
import 'package:uuid/uuid.dart';

class HarvestProvider extends ChangeNotifier {
  final DownloadDao _downloadDao;
  final SyncDao _syncDao;
  final Uuid _uuid = const Uuid();

  String? _draftBatchId;
  double _draftWetLarvaeKg = 0;
  double _draftFrassKg = 0;
  double _draftPupaKg = 0;
  bool _saving = false;

  HarvestProvider(this._downloadDao, this._syncDao);

  String? get draftBatchId => _draftBatchId;
  double get draftWetLarvaeKg => _draftWetLarvaeKg;
  double get draftFrassKg => _draftFrassKg;
  double get draftPupaKg => _draftPupaKg;
  bool get saving => _saving;

  void setBatchId(String batchId) {
    _draftBatchId = batchId;
    notifyListeners();
  }

  void setWetLarvaeKg(double value) {
    _draftWetLarvaeKg = value;
    notifyListeners();
  }

  void setFrassKg(double value) {
    _draftFrassKg = value;
    notifyListeners();
  }

  void setPupaKg(double value) {
    _draftPupaKg = value;
    notifyListeners();
  }

  void reset() {
    _draftBatchId = null;
    _draftWetLarvaeKg = 0;
    _draftFrassKg = 0;
    _draftPupaKg = 0;
    notifyListeners();
  }

  Future<bool> saveHarvest({String? notes, String? photoUrl}) async {
    final batchId = _draftBatchId;
    if (batchId == null || batchId.isEmpty || _draftWetLarvaeKg <= 0) {
      return false;
    }

    final now = DateTime.now();
    final remoteId = _uuid.v4();
    _saving = true;
    notifyListeners();

    final companion = HarvestsCompanion.insert(
      remoteId: drift.Value(remoteId),
      batchId: batchId,
      wetLarvaeKg: _draftWetLarvaeKg,
      frassKg: drift.Value(_draftFrassKg),
      pupaKg: drift.Value(_draftPupaKg),
      harvestedAt: now,
      notes: drift.Value(notes),
      photoUrl: drift.Value(photoUrl),
      createdAt: drift.Value(now),
      updatedAt: drift.Value(now),
    );

    try {
      await _downloadDao.insertHarvest(companion);

      await _syncDao.insertSyncOperation(
        SyncOutboxesCompanion.insert(
          operationId: _uuid.v4(),
          entityType: 'harvest',
          entityId: drift.Value(remoteId),
          operation: drift.Value('create'),
          payload: drift.Value(
            jsonEncode(_harvestToJson(companion, now)),
          ),
        ),
      );

      reset();
      return true;
    } catch (_) {
      return false;
    } finally {
      _saving = false;
      notifyListeners();
    }
  }

  Map<String, dynamic> _harvestToJson(HarvestsCompanion h, DateTime occurredAt) {
    return {
      'batchId': h.batchId.value,
      'wetLarvaeKg': h.wetLarvaeKg.value,
      'frassKg': h.frassKg.value,
      'pupaKg': h.pupaKg.value,
      'occurredAt': occurredAt.toIso8601String(),
      'notes': h.notes.value,
    };
  }
}