import 'package:flutter_test/flutter_test.dart';
import 'package:flyful_farms/core/database/app_database.dart';
import 'package:flyful_farms/features/breeding/presentation/providers/egg_collection_provider.dart';

void main() {
  late AppDatabase db;
  late EggCollectionProvider provider;

  setUp(() {
    db = AppDatabase.inMemory();
    provider = EggCollectionProvider(db.downloadDao, db.syncDao);
  });

  tearDown(() async {
    await db.close();
  });

  test('saveEggCollection requires cage and weight', () async {
    final ok = await provider.saveEggCollection();
    expect(ok, isFalse);
  });

  test('saveEggCollection persists and writes a sync outbox op', () async {
    provider.setCageId('cage-1');
    provider.setEggWeightGrams('250');
    provider.setQuality('good');

    final ok = await provider.saveEggCollection();
    expect(ok, isTrue);

    final eggs = await db.downloadDao.allEggCollections();
    expect(eggs, hasLength(1));
    final e = eggs.first;
    expect(e.cageId, 'cage-1');
    expect(e.eggWeightGrams, '250');
    expect(e.quality, 'good');
    expect(e.remoteId, isNotEmpty);

    final pending = await db.syncDao.getPendingOperations();
    expect(pending, hasLength(1));
    expect(pending.first.entityType, 'egg_collection');
    expect(pending.first.operation, 'create');
    expect(pending.first.entityId, isNotEmpty);
    expect(pending.first.payload, contains('cageId'));
    expect(pending.first.payload, contains('eggWeightGrams'));
  });

  test('saveEggCollection resets the draft after success', () async {
    provider.setCageId('cage-2');
    provider.setEggWeightGrams('120');
    provider.setQuality('best');

    await provider.saveEggCollection();

    expect(provider.draftCageId, isNull);
    expect(provider.draftEggWeightGrams, isEmpty);
  });

  test('saveEggCollection refuses a non-positive weight', () async {
    provider.setCageId('cage-3');
    provider.setEggWeightGrams('0');

    final ok = await provider.saveEggCollection();
    expect(ok, isFalse);
    expect(await db.downloadDao.allEggCollections(), isEmpty);
  });
}