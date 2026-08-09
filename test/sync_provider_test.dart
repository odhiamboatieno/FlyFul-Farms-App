import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:flyful_farms/core/database/app_database.dart';
import 'package:flyful_farms/core/network/connectivity.dart';
import 'package:flyful_farms/core/sync/sync_controller.dart';
import 'package:flyful_farms/core/sync/sync_service.dart';
import 'package:flyful_farms/features/profile/presentation/providers/sync_provider.dart';
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

class _FakeNetwork implements NetworkInfo {
  @override
  Future<bool> get isConnected async => true;

  @override
  Stream<bool> get onConnectivityChanged => const Stream<bool>.empty();
}

void main() {
  late AppDatabase db;
  late _FakeStorage storage;
  late SyncProvider provider;
  late SyncController controller;

  setUp(() {
    db = AppDatabase.inMemory();
    storage = _FakeStorage();
    final sync = SyncService(
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
                  'status': 'success',
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
      get: (path, {queryParameters}) async => {
            'status': 'success',
            'data': path.contains('/sync/download')
                ? {'changes': <dynamic>[], 'count': 0, 'since': '2026-08-01T00:00:00.000Z'}
                : <dynamic>[],
          },
    );
    controller = SyncController(sync, _FakeNetwork());
    provider = SyncProvider(db.syncDao, controller);
  });

  tearDown(() async {
    controller.dispose();
    await db.close();
  });

  test('loadPending counts queued operations', () async {
    await db.syncDao.insertSyncOperation(
      SyncOutboxesCompanion.insert(
        operationId: 'op-1',
        entityType: 'batch',
        entityId: drift.Value('9b1deb4d-3b7d-4bad-9bdd-2b0d7b3dcb6d'),
        operation: drift.Value('create'),
        payload: drift.Value('{}'),
      ),
    );

    await provider.loadPending();
    expect(provider.pendingCount, 1);
    expect(provider.pendingOperations, hasLength(1));
    expect(provider.pendingOperations.single.entityType, 'batch');
  });

  test('syncNow drains pending ops and updates lastSyncedAt', () async {
    await db.syncDao.insertSyncOperation(
      SyncOutboxesCompanion.insert(
        operationId: 'op-2',
        entityType: 'feeding',
        entityId: drift.Value('9b1deb4d-3b7d-4bad-9bdd-2b0d7b3dcb6d'),
        operation: drift.Value('create'),
        payload: drift.Value('{}'),
      ),
    );

    await provider.loadPending();
    expect(provider.pendingCount, 1);

    await provider.syncNow();

    expect(provider.lastSyncedAt, isNotNull);
    expect(provider.isSyncing, isFalse);
    expect(provider.pendingCount, 0);
  });

  test('pendingCount starts at zero', () async {
    expect(provider.pendingCount, 0);
  });
}