import 'package:flutter_test/flutter_test.dart';
import 'package:flyful_farms/core/database/app_database.dart';
import 'package:flyful_farms/features/feeding/presentation/providers/feeding_provider.dart';

void main() {
  late AppDatabase db;
  late FeedingProvider provider;

  setUp(() {
    db = AppDatabase.inMemory();
    provider = FeedingProvider(db.downloadDao, db.syncDao);
  });

  tearDown(() async {
    await db.close();
  });

  test('saveFeeding requires batch, type, and quantity', () async {
    final ok = await provider.saveFeeding();
    expect(ok, isFalse);
  });

  test('saveFeeding persists a feeding and writes a sync outbox op', () async {
    provider.setBatchId('batch-1');
    provider.setWasteType('vegetables');
    provider.setQuantityKg(12.5);

    final ok = await provider.saveFeeding();
    expect(ok, isTrue);

    final feedings = await db.downloadDao.allFeedings();
    expect(feedings, hasLength(1));
    final f = feedings.first;
    expect(f.batchId, 'batch-1');
    expect(f.wasteType, 'vegetables');
    expect(f.wasteQuantityKg, 12.5);
    expect(f.remoteId, isNotEmpty);

    final pending = await db.syncDao.getPendingOperations();
    expect(pending, hasLength(1));
    expect(pending.first.entityType, 'feeding');
    expect(pending.first.operation, 'create');
    expect(pending.first.entityId, isNotEmpty);
    expect(pending.first.payload, contains('batchId'));
    expect(pending.first.payload, contains('wasteQuantityKg'));
  });

  test('saveFeeding resets the draft after success', () async {
    provider.setBatchId('batch-2');
    provider.setWasteType('fruit');
    provider.setQuantityKg(4);

    await provider.saveFeeding();

    expect(provider.draftBatchId, isNull);
    expect(provider.draftWasteType, isEmpty);
    expect(provider.draftQuantityKg, 0);
  });

  test('saveFeeding refuses a zero quantity', () async {
    provider.setBatchId('batch-3');
    provider.setWasteType('market_waste');

    final ok = await provider.saveFeeding();
    expect(ok, isFalse);
    expect(await db.downloadDao.allFeedings(), isEmpty);
  });
}