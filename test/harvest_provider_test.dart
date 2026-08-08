import 'package:flutter_test/flutter_test.dart';
import 'package:flyful_farms/core/database/app_database.dart';
import 'package:flyful_farms/features/harvest/presentation/providers/harvest_provider.dart';

void main() {
  late AppDatabase db;
  late HarvestProvider provider;

  setUp(() {
    db = AppDatabase.inMemory();
    provider = HarvestProvider(db.downloadDao, db.syncDao);
  });

  tearDown(() async {
    await db.close();
  });

  test('saveHarvest requires batch and larvae weight', () async {
    final ok = await provider.saveHarvest();
    expect(ok, isFalse);
  });

  test('saveHarvest persists a harvest and writes a sync outbox op', () async {
    provider.setBatchId('batch-1');
    provider.setWetLarvaeKg(52.0);
    provider.setFrassKg(18.7);
    provider.setPupaKg(0);

    final ok = await provider.saveHarvest();
    expect(ok, isTrue);

    final harvests = await db.downloadDao.allHarvests();
    expect(harvests, hasLength(1));
    final h = harvests.first;
    expect(h.batchId, 'batch-1');
    expect(h.wetLarvaeKg, 52.0);
    expect(h.frassKg, 18.7);
    expect(h.pupaKg, 0);
    expect(h.remoteId, isNotEmpty);

    final pending = await db.syncDao.getPendingOperations();
    expect(pending, hasLength(1));
    expect(pending.first.entityType, 'harvest');
    expect(pending.first.operation, 'create');
    expect(pending.first.entityId, isNotEmpty);
    expect(pending.first.payload, contains('wetLarvaeKg'));
    expect(pending.first.payload, contains('frassKg'));
  });

  test('saveHarvest resets the draft after success', () async {
    provider.setBatchId('batch-2');
    provider.setWetLarvaeKg(30);

    await provider.saveHarvest();

    expect(provider.draftBatchId, isNull);
    expect(provider.draftWetLarvaeKg, 0);
    expect(provider.draftFrassKg, 0);
  });

  test('saveHarvest refuses a zero larvae weight', () async {
    provider.setBatchId('batch-3');

    final ok = await provider.saveHarvest();
    expect(ok, isFalse);
    expect(await db.downloadDao.allHarvests(), isEmpty);
  });
}