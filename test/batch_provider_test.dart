import 'package:flutter_test/flutter_test.dart';
import 'package:flyful_farms/core/database/app_database.dart';
import 'package:flyful_farms/features/batches/presentation/providers/batch_provider.dart';

void main() {
  late AppDatabase db;
  late BatchProvider provider;

  setUp(() {
    db = AppDatabase.inMemory();
    provider = BatchProvider(db.batchDao, db.syncDao);
  });

  tearDown(() async {
    await db.close();
  });

  test('loadBatches starts empty', () async {
    await provider.loadBatches();
    expect(provider.batches, isEmpty);
    expect(provider.loading, isFalse);
  });

  test('createBatch persists a batch and writes a sync outbox op', () async {
    await provider.createBatch(
      batchNumber: 'BSF-2026-001',
      wasteType: 'market_waste',
      wasteQuantityKg: 20,
      neonatesAdded: 200,
    );

    expect(provider.batches, hasLength(1));
    final b = provider.batches.first;
    expect(b.batchNumber, 'BSF-2026-001');
    expect(b.wasteType, 'market_waste');
    expect(b.wasteQuantityKg, 20);
    expect(b.neonatesAdded, 200);
    expect(b.status, 'active');

    final pending = await db.syncDao.getPendingOperations();
    expect(pending, hasLength(1));
    expect(pending.first.entityType, 'batch');
    expect(pending.first.operation, 'create');
    expect(pending.first.operationId, isNotEmpty);
    expect(pending.first.entityId, isNotEmpty);
    expect(pending.first.payload, contains('batchNumber'));
  });

  test('batchById finds the created batch', () async {
    await provider.createBatch(batchNumber: 'BSF-2026-002', wasteType: 'vegetables', wasteQuantityKg: 5);

    final b = provider.batches.first;
    expect(provider.batchById(b.id), isNotNull);
    expect(provider.batchById(b.id)!.batchNumber, 'BSF-2026-002');
    expect(provider.batchById(999999), isNull);
  });

  test('createBatch generates a batch number default when provided empty', () async {
    await provider.createBatch(batchNumber: 'BSF-X', wasteType: 'kitchen_waste', wasteQuantityKg: 3);
    expect(provider.batches.single.batchNumber, 'BSF-X');
  });

  test('reload preserves batches across calls', () async {
    await provider.createBatch(batchNumber: 'BSF-2026-003', wasteType: 'market_waste', wasteQuantityKg: 10);
    await provider.loadBatches();
    expect(provider.batches, hasLength(1));
  });

  test('deleteBatch removes the row and queues a delete op', () async {
    await provider.createBatch(batchNumber: 'BSF-2026-004', wasteType: 'vegetables', wasteQuantityKg: 8);
    final id = provider.batches.single.id;
    final remoteId = provider.batches.single.remoteId!;

    await provider.deleteBatch(id);

    expect(provider.batches, isEmpty);
    final pending = await db.syncDao.getPendingOperations();
    final delete = pending.firstWhere((op) => op.operation == 'delete');
    expect(delete.entityType, 'batch');
    expect(delete.entityId, remoteId);
  });

  test('updateBatch persists changes and queues an update op', () async {
    await provider.createBatch(batchNumber: 'BSF-2026-005', wasteType: 'vegetables', wasteQuantityKg: 8);
    final id = provider.batches.single.id;
    final remoteId = provider.batches.single.remoteId!;

    await provider.updateBatch(
      id,
      batchNumber: 'BSF-2026-005-EDITED',
      wasteQuantityKg: 10,
      status: 'completed',
    );

    final b = provider.batchById(id)!;
    expect(b.batchNumber, 'BSF-2026-005-EDITED');
    expect(b.wasteQuantityKg, 10);
    expect(b.status, 'completed');

    final pending = await db.syncDao.getPendingOperations();
    final update = pending.firstWhere((op) => op.operation == 'update');
    expect(update.entityType, 'batch');
    expect(update.entityId, remoteId);
    expect(update.payload, contains('completed'));
  });

  test('updateBatch does nothing for unknown id', () async {
    await provider.createBatch(batchNumber: 'BSF-2026-006', wasteType: 'market_waste', wasteQuantityKg: 4);

    await provider.updateBatch(999999, batchNumber: 'nope');

    expect(provider.batches.single.batchNumber, 'BSF-2026-006');
  });
}
