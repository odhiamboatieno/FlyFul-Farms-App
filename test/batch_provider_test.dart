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
}
