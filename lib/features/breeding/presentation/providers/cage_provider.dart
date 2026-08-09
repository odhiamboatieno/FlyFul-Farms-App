import 'package:flutter/foundation.dart';
import 'package:flyful_farms/core/database/app_database.dart';
import 'package:flyful_farms/core/database/daos/cage_dao.dart';
import 'package:flyful_farms/core/database/daos/sync_dao.dart';
import 'package:uuid/uuid.dart';
import 'package:drift/drift.dart' as drift;
import 'dart:convert';

class CageProvider extends ChangeNotifier {
  final CageDao _cageDao;
  final SyncDao _syncDao;
  final Uuid _uuid = const Uuid();

  CageProvider(this._cageDao, this._syncDao);

  List<BreedingCage> _cages = [];
  bool _loading = false;
  String? _error;

  List<BreedingCage> get cages => List.unmodifiable(_cages);
  bool get loading => _loading;
  String? get error => _error;

  Future<void> loadCages() async {
    _loading = true;
    _error = null;
    notifyListeners();
    try {
      _cages = await _cageDao.getAllCages();
    } catch (e) {
      _error = 'Could not load cages.';
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  BreedingCage? cageById(int id) {
    for (final c in _cages) {
      if (c.id == id) return c;
    }
    return null;
  }

  Future<void> createCage({
    required String cageNumber,
    String status = 'active',
    int ageDays = 0,
    double pupaLoadedKg = 0,
    String? pupaSource,
    bool attractantInstalled = false,
    bool waterAdded = false,
    String? notes,
  }) async {
    final now = DateTime.now();
    final remoteId = _uuid.v4();
    final companion = BreedingCagesCompanion.insert(
      remoteId: drift.Value(remoteId),
      cageNumber: drift.Value(cageNumber),
      status: drift.Value(status),
      ageDays: drift.Value(ageDays),
      pupaLoadedKg: drift.Value(pupaLoadedKg),
      pupaSource: drift.Value(pupaSource),
      attractantInstalled: drift.Value(attractantInstalled),
      waterAdded: drift.Value(waterAdded),
      notes: drift.Value(notes),
      createdAt: drift.Value(now),
      updatedAt: drift.Value(now),
    );

    await _cageDao.insertCage(companion);

    await _syncDao.insertSyncOperation(
      SyncOutboxesCompanion.insert(
        operationId: _uuid.v4(),
        entityType: 'breeding_cage',
        entityId: drift.Value(remoteId),
        operation: drift.Value('create'),
        payload: drift.Value(
          jsonEncode(_cageToJson(companion)),
        ),
      ),
    );

    await loadCages();
  }

  Future<void> deleteCage(int id) async {
    final cage = cageById(id);
    if (cage == null) return;

    if (cage.remoteId != null && cage.remoteId!.isNotEmpty) {
      await _syncDao.insertSyncOperation(
        SyncOutboxesCompanion.insert(
          operationId: _uuid.v4(),
          entityType: 'breeding_cage',
          entityId: drift.Value(cage.remoteId),
          operation: drift.Value('delete'),
          payload: drift.Value('{}'),
        ),
      );
    }

    await _cageDao.deleteCage(id);
    await loadCages();
  }

  Map<String, dynamic> _cageToJson(BreedingCagesCompanion c) {
    return {
      'cageNumber': c.cageNumber.value,
      'status': c.status.value,
      'ageDays': c.ageDays.value,
      'pupaLoadedKg': c.pupaLoadedKg.value,
      'pupaSource': c.pupaSource.value,
      'attractantInstalled': c.attractantInstalled.value,
      'waterAdded': c.waterAdded.value,
      'notes': c.notes.value,
    };
  }
}