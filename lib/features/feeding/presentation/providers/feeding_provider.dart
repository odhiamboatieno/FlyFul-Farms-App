import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flyful_farms/core/database/app_database.dart';
import 'package:flyful_farms/core/database/daos/download_dao.dart';
import 'package:flyful_farms/core/database/daos/sync_dao.dart';
import 'package:drift/drift.dart' as drift;
import 'package:uuid/uuid.dart';

class FeedingProvider extends ChangeNotifier {
  final DownloadDao _downloadDao;
  final SyncDao _syncDao;
  final Uuid _uuid = const Uuid();

  String? _draftBatchId;
  String _draftWasteType = '';
  double _draftQuantityKg = 0;
  DateTime? _draftDate;
  bool _saving = false;

  FeedingProvider(this._downloadDao, this._syncDao);

  String? get draftBatchId => _draftBatchId;
  String get draftWasteType => _draftWasteType;
  double get draftQuantityKg => _draftQuantityKg;
  DateTime? get draftDate => _draftDate;
  bool get saving => _saving;

  void setBatchId(String batchId) {
    _draftBatchId = batchId;
    notifyListeners();
  }

  void setWasteType(String wasteType) {
    _draftWasteType = wasteType;
    notifyListeners();
  }

  void setQuantityKg(double quantityKg) {
    _draftQuantityKg = quantityKg;
    notifyListeners();
  }

  void setDate(DateTime date) {
    _draftDate = date;
    notifyListeners();
  }

  void reset() {
    _draftBatchId = null;
    _draftWasteType = '';
    _draftQuantityKg = 0;
    _draftDate = null;
    notifyListeners();
  }

  Future<bool> saveFeeding({String? notes, String? photoUrl, DateTime? date}) async {
    final batchId = _draftBatchId;
    if (batchId == null || batchId.isEmpty || _draftWasteType.isEmpty || _draftQuantityKg <= 0) {
      return false;
    }

    final now = DateTime.now();
    final fedAt = date ?? now;
    final remoteId = _uuid.v4();
    _saving = true;
    notifyListeners();

    final companion = FeedingsCompanion.insert(
      remoteId: drift.Value(remoteId),
      batchId: batchId,
      wasteQuantityKg: _draftQuantityKg,
      wasteType: _draftWasteType,
      fedAt: fedAt,
      notes: drift.Value(notes),
      photoUrl: drift.Value(photoUrl),
      createdAt: drift.Value(now),
      updatedAt: drift.Value(now),
    );

    try {
      await _downloadDao.insertFeeding(companion);

      await _syncDao.insertSyncOperation(
        SyncOutboxesCompanion.insert(
          operationId: _uuid.v4(),
          entityType: 'feeding',
          entityId: drift.Value(remoteId),
          operation: drift.Value('create'),
          payload: drift.Value(
            jsonEncode(_feedingToJson(companion, fedAt)),
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

  Map<String, dynamic> _feedingToJson(FeedingsCompanion f, DateTime occurredAt) {
    return {
      'batchId': f.batchId.value,
      'wasteType': f.wasteType.value,
      'wasteQuantityKg': f.wasteQuantityKg.value,
      'occurredAt': occurredAt.toIso8601String(),
      'notes': f.notes.value,
      'photoUrl': f.photoUrl.value,
    };
  }
}