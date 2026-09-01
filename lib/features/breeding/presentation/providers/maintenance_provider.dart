import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flyful_farms/core/database/app_database.dart';
import 'package:flyful_farms/core/database/daos/download_dao.dart';
import 'package:flyful_farms/core/database/daos/sync_dao.dart';
import 'package:drift/drift.dart' as drift;
import 'package:uuid/uuid.dart';

class MaintenanceProvider extends ChangeNotifier {
  final DownloadDao _downloadDao;
  final SyncDao _syncDao;
  final Uuid _uuid = const Uuid();

  String? _draftCageId;
  bool _waterChanged = false;
  bool _attractantReplaced = false;
  bool _cleaningDone = false;
  bool _saving = false;

  MaintenanceProvider(this._downloadDao, this._syncDao);

  String? get draftCageId => _draftCageId;
  bool get waterChanged => _waterChanged;
  bool get attractantReplaced => _attractantReplaced;
  bool get cleaningDone => _cleaningDone;
  bool get saving => _saving;

  void setCageId(String cageId) {
    _draftCageId = cageId;
    notifyListeners();
  }

  void setWaterChanged(bool value) {
    _waterChanged = value;
    notifyListeners();
  }

  void setAttractantReplaced(bool value) {
    _attractantReplaced = value;
    notifyListeners();
  }

  void setCleaningDone(bool value) {
    _cleaningDone = value;
    notifyListeners();
  }

  void reset() {
    _draftCageId = null;
    _waterChanged = false;
    _attractantReplaced = false;
    _cleaningDone = false;
    notifyListeners();
  }

  Future<bool> saveMaintenance({String? notes, DateTime? date}) async {
    final cageId = _draftCageId;
    if (cageId == null || cageId.isEmpty) {
      return false;
    }

    final now = DateTime.now();
    final maintenanceDate = date ?? now;
    final remoteId = _uuid.v4();
    _saving = true;
    notifyListeners();

    final companion = CageMaintenancesCompanion.insert(
      remoteId: drift.Value(remoteId),
      cageId: cageId,
      maintenanceDate: maintenanceDate,
      waterChanged: drift.Value(_waterChanged),
      attractantReplaced: drift.Value(_attractantReplaced),
      cleaningDone: drift.Value(_cleaningDone),
      notes: drift.Value(notes),
      createdAt: drift.Value(now),
      updatedAt: drift.Value(now),
    );

    try {
      await _downloadDao.insertCageMaintenance(companion);

      await _syncDao.insertSyncOperation(
        SyncOutboxesCompanion.insert(
          operationId: _uuid.v4(),
          entityType: 'cage_maintenance',
          entityId: drift.Value(remoteId),
          operation: drift.Value('create'),
          payload: drift.Value(
            jsonEncode(_maintenanceToJson(companion, maintenanceDate)),
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

  Map<String, dynamic> _maintenanceToJson(CageMaintenancesCompanion c, DateTime occurredAt) {
    return {
      'cageId': c.cageId.value,
      'waterChanged': c.waterChanged.value,
      'attractantReplaced': c.attractantReplaced.value,
      'cleaningDone': c.cleaningDone.value,
      'occurredAt': occurredAt.toIso8601String(),
      'notes': c.notes.value,
    };
  }
}