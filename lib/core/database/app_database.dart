import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:io';
import 'tables/batches.dart';
import 'tables/cages.dart';
import 'tables/feedings.dart';
import 'tables/harvests.dart';
import 'tables/egg_collections.dart';
import 'tables/maintenance.dart';
import 'tables/sync_outbox.dart';
import 'daos/batch_dao.dart';
import 'daos/cage_dao.dart';
import 'daos/sync_dao.dart';
import 'daos/download_dao.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [Batches, BreedingCages, Feedings, Harvests, EggCollections, CageMaintenances, SyncOutboxes])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());
  AppDatabase.inMemory() : super(NativeDatabase.memory());

  @override
  int get schemaVersion => 4;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) => m.createAll(),
        onUpgrade: (m, from, to) async {
          if (from < 2) {
            await m.addColumn(batches, batches.remoteId);
            await m.addColumn(syncOutboxes, syncOutboxes.operationId);
          }
          if (from < 3) {
            await m.addColumn(breedingCages, breedingCages.remoteId);
          }
          if (from < 4) {
            await m.addColumn(feedings, feedings.remoteId);
            await m.addColumn(harvests, harvests.remoteId);
            await m.addColumn(eggCollections, eggCollections.remoteId);
            await m.addColumn(cageMaintenances, cageMaintenances.remoteId);
          }
        },
      );

  late final batchDao = BatchDao(this);
  late final cageDao = CageDao(this);
  late final syncDao = SyncDao(this);
  late final downloadDao = DownloadDao(this);
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'flyful_farms.db'));
    return NativeDatabase(file);
  });
}
