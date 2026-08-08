import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:flyful_farms/core/database/app_database.dart';
import 'package:flyful_farms/core/network/connectivity.dart';
import 'package:flyful_farms/core/sync/sync_controller.dart';
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

class _FakeNetwork implements NetworkInfo {
  final StreamController<bool> _controller = StreamController<bool>.broadcast();
  bool connected = true;

  @override
  Future<bool> get isConnected async => connected;

  @override
  Stream<bool> get onConnectivityChanged => _controller.stream;

  void emit(bool online) => _controller.add(online);

  Future<void> close() => _controller.close();
}

void main() {
  late AppDatabase db;
  late _FakeStorage storage;
  late _FakeNetwork network;

  setUp(() {
    db = AppDatabase.inMemory();
    storage = _FakeStorage();
    network = _FakeNetwork();
  });

  tearDown(() async {
    await network.close();
    await db.close();
  });

  int callCount = 0;

  SyncController buildController() {
    final sync = SyncService(
      db.syncDao,
      storage,
      post: (path, data) async {
        callCount++;
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
      get: (path, {queryParameters}) async => {'status': 'success', 'data': <dynamic>[]},
    );
    return SyncController(sync, network);
  }

  test('syncNow runs the underlying service and records timestamp', () async {
    callCount = 0;
    await db.syncDao.insertSyncOperation(
      SyncOutboxesCompanion.insert(
        operationId: 'op-1',
        entityType: 'batch',
        entityId: drift.Value('9b1deb4d-3b7d-4bad-9bdd-2b0d7b3dcb6d'),
        operation: drift.Value('create'),
        payload: drift.Value('{}'),
      ),
    );

    final controller = buildController();
    final result = await controller.syncNow();

    expect(callCount, 1);
    expect(result.processed, 1);
    expect(controller.lastSyncedAt, isNotNull);
    expect(controller.isSyncing, isFalse);
  });

  test('start triggers sync when connectivity comes back online', () async {
    callCount = 0;
    await db.syncDao.insertSyncOperation(
      SyncOutboxesCompanion.insert(
        operationId: 'op-2',
        entityType: 'batch',
        entityId: drift.Value('9b1deb4d-3b7d-4bad-9bdd-2b0d7b3dcb6d'),
        operation: drift.Value('create'),
        payload: drift.Value('{}'),
      ),
    );

    final controller = buildController();
    controller.start();
    network.emit(true);

    await Future<void>.delayed(const Duration(milliseconds: 100));
    expect(callCount, 1);

    controller.dispose();
  });

  test('start ignores offline events', () async {
    callCount = 0;
    await db.syncDao.insertSyncOperation(
      SyncOutboxesCompanion.insert(
        operationId: 'op-3',
        entityType: 'batch',
        entityId: drift.Value('9b1deb4d-3b7d-4bad-9bdd-2b0d7b3dcb6d'),
        operation: drift.Value('create'),
        payload: drift.Value('{}'),
      ),
    );

    final controller = buildController();
    controller.start();
    network.emit(false);

    await Future<void>.delayed(const Duration(milliseconds: 100));
    expect(callCount, 0);

    controller.dispose();
  });

  test('start is idempotent', () async {
    final controller = buildController();
    controller.start();
    controller.start();
    controller.dispose();
  });
}
