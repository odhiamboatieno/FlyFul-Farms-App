import 'package:flutter_test/flutter_test.dart';
import 'package:flyful_farms/core/database/app_database.dart';
import 'package:flyful_farms/features/breeding/presentation/providers/maintenance_provider.dart';

void main() {
  late AppDatabase db;
  late MaintenanceProvider provider;

  setUp(() {
    db = AppDatabase.inMemory();
    provider = MaintenanceProvider(db.downloadDao, db.syncDao);
  });

  tearDown(() async {
    await db.close();
  });

  test('saveMaintenance requires a cage', () async {
    final ok = await provider.saveMaintenance();
    expect(ok, isFalse);
  });

  test('saveMaintenance persists and writes a sync outbox op', () async {
    provider.setCageId('cage-1');
    provider.setWaterChanged(true);
    provider.setCleaningDone(true);

    final ok = await provider.saveMaintenance();
    expect(ok, isTrue);

    final items = await db.downloadDao.allMaintenances();
    expect(items, hasLength(1));
    final m = items.first;
    expect(m.cageId, 'cage-1');
    expect(m.waterChanged, isTrue);
    expect(m.attractantReplaced, isFalse);
    expect(m.cleaningDone, isTrue);
    expect(m.remoteId, isNotEmpty);

    final pending = await db.syncDao.getPendingOperations();
    expect(pending, hasLength(1));
    expect(pending.first.entityType, 'cage_maintenance');
    expect(pending.first.operation, 'create');
    expect(pending.first.entityId, isNotEmpty);
    expect(pending.first.payload, contains('cageId'));
    expect(pending.first.payload, contains('waterChanged'));
  });

  test('saveMaintenance resets the draft after success', () async {
    provider.setCageId('cage-2');
    provider.setWaterChanged(true);

    await provider.saveMaintenance();

    expect(provider.draftCageId, isNull);
    expect(provider.waterChanged, isFalse);
    expect(provider.attractantReplaced, isFalse);
    expect(provider.cleaningDone, isFalse);
  });
}