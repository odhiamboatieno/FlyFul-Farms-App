import 'package:flutter_test/flutter_test.dart';
import 'package:flyful_farms/core/database/app_database.dart';
import 'package:flyful_farms/features/records/presentation/providers/record_provider.dart';
import 'package:drift/drift.dart' as drift;

void main() {
  late AppDatabase db;
  late RecordProvider provider;

  setUp(() {
    db = AppDatabase.inMemory();
    provider = RecordProvider(db.downloadDao);
  });

  tearDown(() async {
    await db.close();
  });

  test('loadBatchRecords loads feedings and harvests for a batch', () async {
    await db.downloadDao.insertFeeding(FeedingsCompanion.insert(
      remoteId: drift.Value('f-1'),
      batchId: 'batch-1',
      wasteQuantityKg: 12.5,
      wasteType: 'vegetables',
      fedAt: DateTime(2026, 8, 5),
    ));
    await db.downloadDao.insertHarvest(HarvestsCompanion.insert(
      remoteId: drift.Value('h-1'),
      batchId: 'batch-1',
      wetLarvaeKg: 30.0,
      harvestedAt: DateTime(2026, 8, 6),
    ));

    await provider.loadBatchRecords('batch-1');

    expect(provider.feedings, hasLength(1));
    expect(provider.feedings.first.batchId, 'batch-1');
    expect(provider.harvests, hasLength(1));
    expect(provider.harvests.first.batchId, 'batch-1');
  });

  test('loadBatchRecords filters by batch id', () async {
    await db.downloadDao.insertFeeding(FeedingsCompanion.insert(
      remoteId: drift.Value('f-1'),
      batchId: 'batch-1',
      wasteQuantityKg: 5,
      wasteType: 'fruit',
      fedAt: DateTime(2026, 8, 5),
    ));
    await db.downloadDao.insertFeeding(FeedingsCompanion.insert(
      remoteId: drift.Value('f-2'),
      batchId: 'batch-2',
      wasteQuantityKg: 8,
      wasteType: 'fruit',
      fedAt: DateTime(2026, 8, 5),
    ));

    await provider.loadBatchRecords('batch-1');
    expect(provider.feedings, hasLength(1));
    expect(provider.feedings.single.remoteId, 'f-1');
  });

  test('loadCageRecords loads egg collections and maintenance', () async {
    await db.downloadDao.insertEggCollection(EggCollectionsCompanion.insert(
      remoteId: drift.Value('e-1'),
      cageId: 'cage-1',
      eggWeightGrams: drift.Value('250'),
      quality: drift.Value('good'),
      collectedAt: DateTime(2026, 8, 5),
    ));
    await db.downloadDao.insertCageMaintenance(CageMaintenancesCompanion.insert(
      remoteId: drift.Value('m-1'),
      cageId: 'cage-1',
      maintenanceDate: DateTime(2026, 8, 6),
      waterChanged: drift.Value(true),
      attractantReplaced: drift.Value(false),
      cleaningDone: drift.Value(true),
    ));

    await provider.loadCageRecords('cage-1');

    expect(provider.eggCollections, hasLength(1));
    expect(provider.eggCollections.first.cageId, 'cage-1');
    expect(provider.maintenances, hasLength(1));
    expect(provider.maintenances.first.cageId, 'cage-1');
    expect(provider.maintenances.first.waterChanged, isTrue);
  });
}