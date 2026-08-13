import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:flutter_test/flutter_test.dart';
import 'package:flyful_farms/core/database/app_database.dart';
import 'package:flyful_farms/core/database/daos/sync_dao.dart';

void main() {
  late AppDatabase db;
  late SyncDao dao;

  setUp(() {
    db = AppDatabase.inMemory();
    dao = db.syncDao;
  });

  tearDown(() async {
    await db.close();
  });

  Future<int> insertOp({
    String? operationId,
    String entityType = 'batch',
    String status = 'pending',
    int retryCount = 0,
  }) {
    return dao.insertSyncOperation(
      SyncOutboxesCompanion.insert(
        operationId: operationId ?? 'op-${DateTime.now().microsecondsSinceEpoch}',
        entityType: entityType,
        status: Value(status),
        retryCount: Value(retryCount),
      ),
    );
  }

  test('insertSyncOperation persists and returns an id', () async {
    final id = await insertOp();
    expect(id, greaterThan(0));
  });

  test('getPendingOperations returns pending and retryable failed operations', () async {
    await insertOp(status: 'pending');
    await insertOp(status: 'completed');
    await insertOp(status: 'failed', retryCount: 2);
    await insertOp(status: 'failed', retryCount: 5);

    final pending = await dao.getPendingOperations();
    expect(pending, hasLength(2));
    expect(pending.map((op) => op.status).toSet(), {'pending', 'failed'});
    expect(pending.any((op) => op.retryCount == 5), isFalse);
  });

  test('getPendingOperations orders by newest first', () async {
    await dao.insertSyncOperation(
      SyncOutboxesCompanion.insert(
        operationId: 'op-first',
        entityType: 'first',
        createdAt: Value(DateTime(2026, 8, 1, 10, 0, 0)),
      ),
    );
    await dao.insertSyncOperation(
      SyncOutboxesCompanion.insert(
        operationId: 'op-second',
        entityType: 'second',
        createdAt: Value(DateTime(2026, 8, 1, 11, 0, 0)),
      ),
    );

    final pending = await dao.getPendingOperations();
    expect(pending, hasLength(2));
    expect(pending.first.entityType, 'second');
  });

  test('markAsComplete flips status and timestamp', () async {
    final id = await insertOp();
    await dao.markAsComplete(id);

    final row = await dao.failedOperation(id);
    expect(row, isNotNull);
    expect(row!.status, 'completed');
    expect(row.updatedAt, isNotNull);
  });

  test('markAsFailed increments retryCount and stores error', () async {
    final id = await insertOp();
    await dao.markAsFailed(id, error: 'server 500');

    final row = await dao.failedOperation(id);
    expect(row, isNotNull);
    expect(row!.status, 'failed');
    expect(row.retryCount, 1);
    expect(row.errorMessage, 'server 500');

    await dao.markAsFailed(id, error: 'server 500 again');
    expect(await dao.retryCountFor(id), 2);
  });

  test('deleteSyncOperation removes the row', () async {
    final id = await insertOp();
    final deleted = await dao.deleteSyncOperation(id);
    expect(deleted, 1);
    expect(await dao.failedOperation(id), isNull);
  });

  test('retryCountFor returns 0 for unknown id', () async {
    expect(await dao.retryCountFor(9999), 0);
  });
}
