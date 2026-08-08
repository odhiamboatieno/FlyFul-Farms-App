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

  SyncService buildService({List<Map<String, dynamic>>? farms, bool? succeed}) {
    return SyncService(
      db.syncDao,
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
      get: (path, {queryParameters}) async => {'status': 'success', 'data': farms ?? <dynamic>[]},
    );
  }

  test('syncNow with no pending ops returns empty result', () async {
    final sync = buildService();
    final result = await sync.syncNow();
    expect(result.processed, 0);
    expect(result.failed, 0);
  });

  test('syncNow posts operation matching server contract and drains outbox', () async {
    late Map<String, dynamic> lastBody;
    final remoteId = '9b1deb4d-3b7d-4bad-9bdd-2b0d7b3dcb6d';

    final sync = SyncService(
      db.syncDao,
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

  test('syncNow marks failed ops as failed', () async {
    final sync = buildService(succeed: false);

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
    expect(pending, isEmpty);
  });
}