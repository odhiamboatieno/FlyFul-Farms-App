import 'package:flutter_test/flutter_test.dart';
import 'package:flyful_farms/core/database/app_database.dart';
import 'package:flyful_farms/features/reports/presentation/providers/compare_provider.dart';
import 'package:drift/drift.dart' as drift;

void main() {
  late AppDatabase db;
  late CompareProvider provider;

  setUp(() {
    db = AppDatabase.inMemory();
    provider = CompareProvider(db.downloadDao);
  });

  tearDown(() async {
    await db.close();
  });

  test('load compares this week vs last week', () async {
    final now = DateTime.now();
    final todayStart = DateTime(now.year, now.month, now.day);
    final weekStart = todayStart.subtract(Duration(days: todayStart.weekday - 1));
    final thisWeek = weekStart.add(const Duration(days: 1));
    final lastWeek = weekStart.subtract(const Duration(days: 1));

    await db.downloadDao.insertHarvest(HarvestsCompanion.insert(
      remoteId: drift.Value('h-1'),
      batchId: 'batch-1',
      wetLarvaeKg: 30.0,
      frassKg: drift.Value(10.0),
      harvestedAt: thisWeek,
    ));
    await db.downloadDao.insertHarvest(HarvestsCompanion.insert(
      remoteId: drift.Value('h-2'),
      batchId: 'batch-1',
      wetLarvaeKg: 20.0,
      frassKg: drift.Value(5.0),
      harvestedAt: lastWeek,
    ));
    await db.downloadDao.insertFeeding(FeedingsCompanion.insert(
      remoteId: drift.Value('f-1'),
      batchId: 'batch-1',
      wasteQuantityKg: 15.0,
      wasteType: 'vegetables',
      fedAt: thisWeek,
    ));

    await provider.load();

    expect(provider.larvaeHarvested.thisWeek, 30);
    expect(provider.larvaeHarvested.lastWeek, 20);
    expect(provider.larvaeHarvested.improved, isTrue);
    expect(provider.larvaeHarvested.percentThisWeek, closeTo(1.0, 0.001));
    expect(provider.larvaeHarvested.percentLastWeek, closeTo(20 / 30, 0.001));
    expect(provider.wasteUsed.thisWeek, 15);
    expect(provider.frassCollected.thisWeek, 10);
    expect(provider.overallImproved, isTrue);
  });

  test('bar percents are relative to the larger week', () async {
    final now = DateTime.now();
    final todayStart = DateTime(now.year, now.month, now.day);
    final weekStart = todayStart.subtract(Duration(days: todayStart.weekday - 1));
    final thisWeek = weekStart.add(const Duration(days: 1));
    final lastWeek = weekStart.subtract(const Duration(days: 1));

    await db.downloadDao.insertHarvest(HarvestsCompanion.insert(
      remoteId: drift.Value('h-1'),
      batchId: 'batch-1',
      wetLarvaeKg: 10.0,
      harvestedAt: thisWeek,
    ));
    await db.downloadDao.insertHarvest(HarvestsCompanion.insert(
      remoteId: drift.Value('h-2'),
      batchId: 'batch-1',
      wetLarvaeKg: 40.0,
      harvestedAt: lastWeek,
    ));

    await provider.load();

    expect(provider.larvaeHarvested.percentThisWeek, closeTo(0.25, 0.001));
    expect(provider.larvaeHarvested.percentLastWeek, closeTo(1.0, 0.001));
  });

  test('no records shows zero stats and no improvement', () async {
    await provider.load();

    expect(provider.larvaeHarvested.thisWeek, 0);
    expect(provider.larvaeHarvested.lastWeek, 0);
    expect(provider.overallImproved, isFalse);
    expect(provider.wasteUsed.thisWeek, 0);
  });
}
