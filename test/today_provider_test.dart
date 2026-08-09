import 'package:flutter_test/flutter_test.dart';
import 'package:flyful_farms/core/database/app_database.dart';
import 'package:flyful_farms/features/dashboard/presentation/providers/today_provider.dart';
import 'package:drift/drift.dart' as drift;

void main() {
  late AppDatabase db;
  late TodayProvider provider;

  setUp(() {
    db = AppDatabase.inMemory();
    provider = TodayProvider(db.batchDao, db.cageDao, db.downloadDao);
  });

  tearDown(() async {
    await db.close();
  });

  test('load aggregates counts from local records', () async {
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
    await db.downloadDao.insertFeeding(FeedingsCompanion.insert(
      remoteId: drift.Value('f-1'),
      batchId: 'batch-1',
      wasteQuantityKg: 2.5,
      wasteType: 'vegetables',
      fedAt: now,
    ));
    await db.downloadDao.insertHarvest(HarvestsCompanion.insert(
      remoteId: drift.Value('h-1'),
      batchId: 'batch-1',
      wetLarvaeKg: 5.5,
      harvestedAt: now,
    ));

    await provider.load();

    expect(provider.activeBatchCount, 1);
    expect(provider.cageCount, 1);
    expect(provider.feedingsToday, 1);
    expect(provider.harvestsToday, 1);
    expect(provider.jobsToday, 2);
    expect(provider.harvestKgThisWeek, 6);
    expect(provider.nextBatchName, '001');
    expect(provider.nextCageName, 'A');
  });

  test('empty farm shows zero counts and no names', () async {
    await provider.load();

    expect(provider.activeBatchCount, 0);
    expect(provider.cageCount, 0);
    expect(provider.jobsToday, 0);
    expect(provider.nextBatchName, isNull);
    expect(provider.nextCageName, isNull);
  });
}
