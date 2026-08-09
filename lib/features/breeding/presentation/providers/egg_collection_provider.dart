import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flyful_farms/core/database/app_database.dart';
import 'package:flyful_farms/core/database/daos/download_dao.dart';
import 'package:flyful_farms/core/database/daos/sync_dao.dart';
import 'package:drift/drift.dart' as drift;
import 'package:uuid/uuid.dart';

class EggCollectionProvider extends ChangeNotifier {
  final DownloadDao _downloadDao;
  final SyncDao _syncDao;
  final Uuid _uuid = const Uuid();

  String? _draftCageId;
  String _draftEggWeightGrams = '';
  String _draftQuality = 'best';
  bool _saving = false;

  EggCollectionProvider(this._downloadDao, this._syncDao);

  String? get draftCageId => _draftCageId;
  String get draftEggWeightGrams => _draftEggWeightGrams;
  String get draftQuality => _draftQuality;
  bool get saving => _saving;

  void setCageId(String cageId) {
    _draftCageId = cageId;
    notifyListeners();
  }

  void setEggWeightGrams(String eggWeightGrams) {
    _draftEggWeightGrams = eggWeightGrams;
    notifyListeners();
  }

  void setQuality(String quality) {
    _draftQuality = quality;
    notifyListeners();
  }

  void reset() {
    _draftCageId = null;
    _draftEggWeightGrams = '';
    _draftQuality = 'best';
    notifyListeners();
  }

  Future<bool> saveEggCollection({String? notes, String? photoUrl}) async {
    final cageId = _draftCageId;
    final weight = double.tryParse(_draftEggWeightGrams);
    if (cageId == null || cageId.isEmpty || weight == null || weight <= 0) {
      return false;
    }

    final now = DateTime.now();
    final remoteId = _uuid.v4();
    _saving = true;
    notifyListeners();

    final companion = EggCollectionsCompanion.insert(
      remoteId: drift.Value(remoteId),
      cageId: cageId,
      eggWeightGrams: drift.Value(_draftEggWeightGrams),
      quality: drift.Value(_draftQuality),
      collectedAt: now,
      notes: drift.Value(notes),
      photoUrl: drift.Value(photoUrl),
      createdAt: drift.Value(now),
      updatedAt: drift.Value(now),
    );

    try {
      await _downloadDao.insertEggCollection(companion);

      await _syncDao.insertSyncOperation(
        SyncOutboxesCompanion.insert(
          operationId: _uuid.v4(),
          entityType: 'egg_collection',
          entityId: drift.Value(remoteId),
          operation: drift.Value('create'),
          payload: drift.Value(
            jsonEncode(_eggToJson(companion, now)),
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

  Map<String, dynamic> _eggToJson(EggCollectionsCompanion e, DateTime occurredAt) {
    return {
      'cageId': e.cageId.value,
      'eggWeightGrams': double.tryParse(e.eggWeightGrams.value),
      'quality': e.quality.value,
      'occurredAt': occurredAt.toIso8601String(),
      'notes': e.notes.value,
    };
  }
}