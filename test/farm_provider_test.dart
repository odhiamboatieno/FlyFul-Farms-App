import 'package:flutter_test/flutter_test.dart';
import 'package:flyful_farms/core/database/app_database.dart';
import 'package:flyful_farms/features/dashboard/presentation/providers/farm_provider.dart';
import 'package:drift/drift.dart' as drift;

void main() {
  late AppDatabase db;
  late FarmProvider provider;

  setUp(() {
    db = AppDatabase.inMemory();
    provider = FarmProvider(db.batchDao, db.cageDao, db.downloadDao);
  });

  tearDown(() async {
    await db.close();
  });

  test('load aggregates total harvest and egg stats', () async {
    final now = DateTime.now();

    await db.batchDao.insertBatch(BatchesCompanion.insert(
      remoteId: drift.Value('batch-1'),
      batchNumber: drift.Value('001'),
      wasteType: drift.Value('vegetables'),
      wasteQuantityKg: drift.Value(10),
      status: drift.Value('active'),
      startDate: now.toIso8601String(),
      expectedHarvestDate: '',
    ));
    await db.cageDao.insertCage(BreedingCagesCompanion.insert(
      remoteId: drift.Value('cage-1'),
      cageNumber: drift.Value('A'),
      status: drift.Value('active'),
    ));
    await db.downloadDao.insertHarvest(HarvestsCompanion.insert(
      remoteId: drift.Value('h-1'),
      batchId: 'batch-1',
      wetLarvaeKg: 5.5,
      frassKg: drift.Value(2.0),
      pupaKg: drift.Value(1.5),
      harvestedAt: now,
    ));
    await db.downloadDao.insertHarvest(HarvestsCompanion.insert(
      remoteId: drift.Value('h-2'),
      batchId: 'batch-1',
      wetLarvaeKg: 4.5,
      frassKg: drift.Value(1.0),
      pupaKg: drift.Value(0.5),
      harvestedAt: now,
    ));
    await db.downloadDao.insertEggCollection(EggCollectionsCompanion.insert(
      remoteId: drift.Value('e-1'),
      cageId: 'cage-1',
      eggWeightGrams: drift.Value('250'),
      quality: drift.Value('good'),
      collectedAt: now,
    ));

    await provider.load();

    expect(provider.batchCount, 1);
    expect(provider.cageCount, 1);
    expect(provider.larvaeKg, 10.0);
    expect(provider.frassKg, 3.0);
    expect(provider.pupaKg, 2.0);
    expect(provider.eggGrams, 250.0);
    expect(provider.harvestKgThisWeek, 10);
  });

  test('empty farm shows zero stats', () async {
    await provider.load();

    expect(provider.batchCount, 0);
    expect(provider.larvaeKg, 0);
    expect(provider.eggGrams, 0);
    expect(provider.harvestKgThisWeek, 0);
  });
}
