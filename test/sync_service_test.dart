import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:flyful_farms/core/database/app_database.dart';
import 'package:flyful_farms/core/sync/sync_service.dart';
import 'package:drift/drift.dart' as drift;

class _FakeStorage implements SyncStorage {
  final Map<String, String> store = {};

  @override
  Future<String?> read(String key) async => store[key];

  @override
  Future<void> write(String key, String value) async {
    store[key] = value;
  }
}

void main() {
  late AppDatabase db;
  late _FakeStorage storage;

  setUp(() {
    db = AppDatabase.inMemory();
    storage = _FakeStorage();
  });

  tearDown(() async {
    await db.close();
  });

  SyncService buildService({List<Map<String, dynamic>>? farms, bool? succeed, Map<String, dynamic>? download}) {
    return SyncService(
      db.syncDao,
      db.downloadDao,
      storage,
      post: (path, data) async {
        final operations = (data['operations'] as List).cast<Map<String, dynamic>>();
        final results = operations
            .map((op) => {
                  'operationId': op['operationId'],
                  'entityType': op['entityType'],
                  'entityId': op['entityId'],
                  'status': (succeed ?? true) ? 'success' : 'error',
                })
            .toList();
        return {
          'status': 'success',
          'data': {
            'processed': results.length,
            'conflictCount': 0,
            'results': results,
            'conflicts': <dynamic>[],
          },
        };
      },
      get: (path, {queryParameters}) async {
        if (path.contains('/sync/download')) {
          return download ??
              {
                'status': 'success',
                'data': {'changes': <dynamic>[], 'count': 0, 'since': '2026-08-01T00:00:00.000Z'},
              };
        }
        return {'status': 'success', 'data': farms ?? <dynamic>[]};
      },
    );
  }

  test('syncNow with no pending ops returns empty result', () async {
    final sync = buildService();
    final result = await sync.syncNow();
    expect(result.processed, 0);
    expect(result.failed, 0);
  });

  test('batch create without a farm stays pending instead of failing', () async {
    var uploadCalled = false;
    final sync = SyncService(
      db.syncDao,
      db.downloadDao,
      storage,
      post: (path, data) async {
        uploadCalled = true;
        return {
          'status': 'success',
          'data': {'processed': 0, 'conflictCount': 0, 'results': <dynamic>[], 'conflicts': <dynamic>[]},
        };
      },
      get: (path, {queryParameters}) async => {
        'status': 'success',
        'data': <dynamic>[],
      },
    );

    await db.syncDao.insertSyncOperation(
      SyncOutboxesCompanion.insert(
        operationId: 'op-no-farm',
        entityType: 'batch',
        entityId: drift.Value('e2e4d1a5-0000-0000-0000-000000000099'),
        operation: drift.Value('create'),
        payload: drift.Value('{"batchNumber":"B-1"}'),
      ),
    );

    final result = await sync.syncNow();

    expect(uploadCalled, isFalse);
    expect(result.processed, 0);
    expect(result.failed, 0);
    final pending = await db.syncDao.getPendingOperations();
    expect(pending, hasLength(1));
    expect(pending.single.operationId, 'op-no-farm');
  });

  test('syncNow posts operation matching server contract and drains outbox', () async {
    late Map<String, dynamic> lastBody;
    final remoteId = '9b1deb4d-3b7d-4bad-9bdd-2b0d7b3dcb6d';

    final sync = SyncService(
      db.syncDao,
      db.downloadDao,
      storage,
      post: (path, data) async {
        lastBody = data;
        return {
          'status': 'success',
          'data': {
            'processed': 1,
            'conflictCount': 0,
            'results': [
              {
                'operationId': 'op-1',
                'entityType': 'batch',
                'entityId': remoteId,
                'status': 'success',
              }
            ],
            'conflicts': <dynamic>[],
          },
        };
      },
      get: (path, {queryParameters}) async => {'status': 'success', 'data': <dynamic>[]},
    );

    await db.syncDao.insertSyncOperation(
      SyncOutboxesCompanion.insert(
        operationId: 'op-1',
        entityType: 'batch',
        entityId: drift.Value(remoteId),
        operation: drift.Value('create'),
        payload: drift.Value(
          jsonEncode({'batchNumber': 'BSF-2026-001', 'wasteType': 'market_waste'}),
        ),
      ),
    );

    await storage.write('sync_farm_id', 'farm-1');

    final result = await sync.syncNow();
    expect(result.processed, 1);

    expect(lastBody['deviceId'], isNotEmpty);
    final ops = lastBody['operations'] as List;
    expect(ops, hasLength(1));
    final op = ops.first as Map<String, dynamic>;
    expect(op['operationId'], 'op-1');
    expect(op['entityType'], 'batch');
    expect(op['entityId'], remoteId);
    expect(op['operation'], 'create');
    expect(op['payload'], containsPair('batchNumber', 'BSF-2026-001'));
    expect(op['occurredAt'], isNotEmpty);

    final pending = await db.syncDao.getPendingOperations();
    expect(pending, isEmpty);
  });

  test('deviceId is stable and farmId cached', () async {
    final sync = buildService(farms: [
      {'id': 'farm-1', 'name': 'Flyful Farm'},
    ]);

    final first = await sync.deviceId();
    final second = await sync.deviceId();
    expect(first, second);

    await db.syncDao.insertSyncOperation(
      SyncOutboxesCompanion.insert(
        operationId: 'op-2',
        entityType: 'batch',
        entityId: drift.Value('e2e4d1a5-0000-0000-0000-000000000001'),
        operation: drift.Value('create'),
        payload: drift.Value('{}'),
      ),
    );
    await sync.syncNow();

    expect(storage.store, containsPair('sync_farm_id', 'farm-1'));
    expect(storage.store, containsPair('sync_device_id', first));
  });

  test('clearFarmId forgets the cached farm', () async {
    final sync = buildService(farms: [
      {'id': 'farm-1', 'name': 'Flyful Farm'},
    ]);
    await sync.farmId();
    expect(storage.store, containsPair('sync_farm_id', 'farm-1'));

    await sync.clearFarmId();

    expect(storage.store['sync_farm_id'], isEmpty);
  });

  test('syncNow marks failed ops as failed', () async {
    final sync = buildService(succeed: false);
    await storage.write('sync_farm_id', 'farm-1');

    await db.syncDao.insertSyncOperation(
      SyncOutboxesCompanion.insert(
        operationId: 'op-3',
        entityType: 'batch',
        entityId: drift.Value('e2e4d1a5-0000-0000-0000-000000000002'),
        operation: drift.Value('create'),
        payload: drift.Value('{}'),
      ),
    );
    final result = await sync.syncNow();
    expect(result.failed, 1);

    final pending = await db.syncDao.getPendingOperations();
    expect(pending, hasLength(1));
    expect(pending.single.status, 'failed');
    expect(pending.single.retryCount, 1);
  });

  test('syncDownload applies server changes to local tables', () async {
    final sync = buildService(download: {
      'status': 'success',
      'data': {
        'changes': [
          {
            'entityType': 'feeding',
            'entityId': 'f1',
            'payload': {'id': 'f1', 'batchId': 'b1', 'wasteType': 'vegetable', 'wasteQuantityKg': 12.5, 'occurredAt': '2026-08-05T10:00:00.000Z'},
          },
          {
            'entityType': 'egg_collection',
            'entityId': 'e1',
            'payload': {'id': 'e1', 'cageId': 'c1', 'eggWeightGrams': '250', 'quality': 'good', 'collectionDate': '2026-08-05T10:00:00.000Z'},
          },
        ],
        'count': 2,
        'since': '2026-08-06T00:00:00.000Z',
      },
    });

    final applied = await sync.syncDownload();

    expect(applied, 2);
    expect(await db.downloadDao.allFeedings(), hasLength(1));
    expect(await db.downloadDao.allEggCollections(), hasLength(1));
    expect(storage.store['sync_last_download'], '2026-08-06T00:00:00.000Z');
  });

  test('syncDownload is idempotent for repeated changes', () async {
    final sync = buildService(download: {
      'status': 'success',
      'data': {
        'changes': [
          {
            'entityType': 'harvest',
            'entityId': 'h1',
            'payload': {'id': 'h1', 'batchId': 'b1', 'wetLarvaeKg': 30.0, 'harvestDate': '2026-08-05T10:00:00.000Z'},
          },
        ],
        'count': 1,
        'since': '2026-08-06T00:00:00.000Z',
      },
    });

    await sync.syncDownload();
    await sync.syncDownload();

    expect(await db.downloadDao.allHarvests(), hasLength(1));
  });

  test('syncDownload applies batch and breeding cage changes', () async {
    final sync = buildService(download: {
      'status': 'success',
      'data': {
        'changes': [
          {
            'entityType': 'batch',
            'entityId': 'b1',
            'payload': {
              'id': 'b1',
              'batchNumber': 'B-100',
              'wasteType': 'vegetable',
              'wasteQuantityKg': 40,
              'neonatesAdded': 5000,
              'status': 'active',
              'dayNumber': 3,
              'startDate': '2026-08-01T00:00:00.000Z',
              'updatedAt': '2026-08-05T10:00:00.000Z',
            },
          },
          {
            'entityType': 'breeding_cage',
            'entityId': 'c1',
            'payload': {
              'id': 'c1',
              'cageNumber': 'C-7',
              'status': 'active',
              'ageDays': 12,
              'pupaLoadedKg': 8.5,
              'attractantInstalled': true,
              'waterAdded': false,
              'updatedAt': '2026-08-05T10:00:00.000Z',
            },
          },
        ],
        'count': 2,
        'since': '2026-08-06T00:00:00.000Z',
      },
    });

    final applied = await sync.syncDownload();

    expect(applied, 2);
    final batches = await db.batchDao.getAllBatches();
    expect(batches, hasLength(1));
    expect(batches.single.batchNumber, 'B-100');
    expect(batches.single.remoteId, 'b1');
    final cages = await db.cageDao.getAllCages();
    expect(cages, hasLength(1));
    expect(cages.single.cageNumber, 'C-7');
    expect(cages.single.attractantInstalled, isTrue);
  });

  test('fresh device bootstraps full history and advances the cursor', () async {
    final requestedSinces = <String>[];
    final sync = SyncService(
      db.syncDao,
      db.downloadDao,
      storage,
      post: (path, data) async => {'status': 'success', 'data': {'processed': 0, 'conflictCount': 0, 'results': <dynamic>[], 'conflicts': <dynamic>[]}},
      get: (path, {queryParameters}) async {
        requestedSinces.add(queryParameters?['since']?.toString() ?? '');
        return {
          'status': 'success',
          'data': {
            'changes': <dynamic>[],
            'count': 0,
            'since': '2026-08-10T12:00:00.000Z',
          },
        };
      },
    );

    await sync.syncDownload();

    expect(requestedSinces, hasLength(1));
    expect(requestedSinces.first, startsWith('1970-'));
    expect(storage.store['sync_last_download'], '2026-08-10T12:00:00.000Z');
  });

  test('syncDownload applies delete tombstones locally', () async {
    await db.downloadDao.upsertBatch(Batche(
      id: 0,
      remoteId: 'b1',
      batchNumber: 'B-1',
      farmerId: '',
      farmerName: '',
      wasteType: 'mixed',
      wasteQuantityKg: 10,
      neonatesAdded: 0,
      status: 'active',
      dayNumber: 1,
      startDate: '2026-08-01T00:00:00.000Z',
      expectedHarvestDate: '',
      createdAt: DateTime(2026, 8, 1),
      updatedAt: DateTime(2026, 8, 1),
    ));
    await db.downloadDao.upsertBreedingCage(BreedingCage(
      id: 0,
      remoteId: 'c1',
      cageNumber: 'C-1',
      farmerId: '',
      status: 'active',
      ageDays: 1,
      pupaLoadedKg: 0,
      attractantInstalled: false,
      waterAdded: false,
      createdAt: DateTime(2026, 8, 1),
      updatedAt: DateTime(2026, 8, 1),
    ));

    final sync = buildService(download: {
      'status': 'success',
      'data': {
        'changes': [
          {
            'entityType': 'batch',
            'entityId': 'b1',
            'operation': 'delete',
            'payload': {'id': 'b1'},
          },
          {
            'entityType': 'breeding_cage',
            'entityId': 'c1',
            'operation': 'delete',
            'payload': {'id': 'c1'},
          },
        ],
        'count': 2,
        'since': '2026-08-10T00:00:00.000Z',
      },
    });

    final applied = await sync.syncDownload();

    expect(applied, 2);
    expect(await db.batchDao.getAllBatches(), isEmpty);
    expect(await db.cageDao.getAllCages(), isEmpty);
  });

  test('fetchConflicts returns the server conflict list', () async {
    final sync = SyncService(
      db.syncDao,
      db.downloadDao,
      storage,
      post: (path, data) async => {'status': 'success', 'data': <dynamic>[]},
      get: (path, {queryParameters}) async => {
        'status': 'success',
        'data': [
          {'id': 'conf-1', 'entityType': 'batch', 'reason': 'Entity changed'},
        ],
      },
    );

    final conflicts = await sync.fetchConflicts();

    expect(conflicts, hasLength(1));
    expect(conflicts.single['id'], 'conf-1');
  });

  test('resolveConflict posts the resolution and returns success', () async {
    String? postedPath;
    late Map<String, dynamic> postedBody;
    final sync = SyncService(
      db.syncDao,
      db.downloadDao,
      storage,
      post: (path, data) async {
        postedPath = path;
        postedBody = data;
        return {'status': 'success', 'data': <dynamic>[]};
      },
      get: (path, {queryParameters}) async => {'status': 'success', 'data': <dynamic>[]},
    );

    final ok = await sync.resolveConflict('conf-1', 'client_wins');

    expect(ok, isTrue);
    expect(postedPath, '/sync/conflicts/conf-1/resolve');
    expect(postedBody, {'resolution': 'client_wins'});
  });
}