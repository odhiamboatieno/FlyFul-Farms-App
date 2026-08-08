import 'package:flutter_test/flutter_test.dart';
import 'package:flyful_farms/core/database/app_database.dart';
import 'package:flyful_farms/features/breeding/presentation/providers/cage_provider.dart';

void main() {
  late AppDatabase db;
  late CageProvider provider;

  setUp(() {
    db = AppDatabase.inMemory();
    provider = CageProvider(db.cageDao, db.syncDao);
  });

  tearDown(() async {
    await db.close();
  });

  test('loadCages starts empty', () async {
    await provider.loadCages();
    expect(provider.cages, isEmpty);
    expect(provider.loading, isFalse);
  });

  test('createCage persists a cage and writes a sync outbox op', () async {
    await provider.createCage(
      cageNumber: 'Cage A',
      ageDays: 4,
      pupaLoadedKg: 3.2,
      waterAdded: true,
    );

    expect(provider.cages, hasLength(1));
    final c = provider.cages.first;
    expect(c.cageNumber, 'Cage A');
    expect(c.ageDays, 4);
    expect(c.pupaLoadedKg, 3.2);
    expect(c.waterAdded, isTrue);
    expect(c.status, 'active');

    final pending = await db.syncDao.getPendingOperations();
    expect(pending, hasLength(1));
    expect(pending.first.entityType, 'breeding_cage');
    expect(pending.first.operation, 'create');
    expect(pending.first.operationId, isNotEmpty);
    expect(pending.first.entityId, isNotEmpty);
    expect(pending.first.payload, contains('cageNumber'));
  });

  test('cageById finds the created cage', () async {
    await provider.createCage(cageNumber: 'Cage B', pupaLoadedKg: 2.8);

    final c = provider.cages.first;
    expect(provider.cageById(c.id), isNotNull);
    expect(provider.cageById(c.id)!.cageNumber, 'Cage B');
    expect(provider.cageById(999999), isNull);
  });

  test('cage defaults to active with given status', () async {
    await provider.createCage(cageNumber: 'Cage C', status: 'empty');
    expect(provider.cages.single.status, 'empty');
  });

  test('reload preserves cages across calls', () async {
    await provider.createCage(cageNumber: 'Cage D');
    await provider.loadCages();
    expect(provider.cages, hasLength(1));
  });
}