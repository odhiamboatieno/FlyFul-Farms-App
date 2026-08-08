import 'package:drift/drift.dart';
import 'package:flyful_farms/core/database/app_database.dart';
import 'package:flyful_farms/core/database/tables/feedings.dart';
import 'package:flyful_farms/core/database/tables/harvests.dart';
import 'package:flyful_farms/core/database/tables/egg_collections.dart';
import 'package:flyful_farms/core/database/tables/maintenance.dart';

part 'download_dao.g.dart';

@DriftAccessor(tables: [Feedings, Harvests, EggCollections, CageMaintenances])
class DownloadDao extends DatabaseAccessor<AppDatabase> {
  final AppDatabase db;

  DownloadDao(this.db) : super(db);

  Future<int> upsertFeeding(Feeding feeding) async {
    final existing = await (select(db.feedings)
          ..where((t) => t.remoteId.equals(feeding.remoteId!)))
        .getSingleOrNull();
    if (existing != null) {
      await (update(db.feedings)..where((t) => t.id.equals(existing.id)))
          .write(feeding);
      return existing.id;
    }
    return await into(db.feedings).insert(
      FeedingsCompanion.insert(
        remoteId: Value(feeding.remoteId),
        batchId: feeding.batchId,
        wasteQuantityKg: feeding.wasteQuantityKg,
        wasteType: feeding.wasteType,
        fedAt: feeding.fedAt,
        notes: Value(feeding.notes),
      ),
    );
  }

  Future<int> upsertHarvest(Harvest harvest) async {
    final existing = await (select(db.harvests)
          ..where((t) => t.remoteId.equals(harvest.remoteId!)))
        .getSingleOrNull();
    if (existing != null) {
      await (update(db.harvests)..where((t) => t.id.equals(existing.id)))
          .write(harvest);
      return existing.id;
    }
    return await into(db.harvests).insert(
      HarvestsCompanion.insert(
        remoteId: Value(harvest.remoteId),
        batchId: harvest.batchId,
        wetLarvaeKg: harvest.wetLarvaeKg,
        frassKg: Value(harvest.frassKg),
        pupaKg: Value(harvest.pupaKg),
        harvestedAt: harvest.harvestedAt,
        notes: Value(harvest.notes),
      ),
    );
  }

  Future<int> upsertEggCollection(EggCollection egg) async {
    final existing = await (select(db.eggCollections)
          ..where((t) => t.remoteId.equals(egg.remoteId!)))
        .getSingleOrNull();
    if (existing != null) {
      await (update(db.eggCollections)..where((t) => t.id.equals(existing.id)))
          .write(egg);
      return existing.id;
    }
    return await into(db.eggCollections).insert(
      EggCollectionsCompanion.insert(
        remoteId: Value(egg.remoteId),
        cageId: egg.cageId,
        eggWeightGrams: Value(egg.eggWeightGrams),
        quality: Value(egg.quality),
        collectedAt: egg.collectedAt,
        notes: Value(egg.notes),
      ),
    );
  }

  Future<int> upsertCageMaintenance(CageMaintenance m) async {
    final existing = await (select(db.cageMaintenances)
          ..where((t) => t.remoteId.equals(m.remoteId!)))
        .getSingleOrNull();
    if (existing != null) {
      await (update(db.cageMaintenances)..where((t) => t.id.equals(existing.id)))
          .write(m);
      return existing.id;
    }
    return await into(db.cageMaintenances).insert(
      CageMaintenancesCompanion.insert(
        remoteId: Value(m.remoteId),
        cageId: m.cageId,
        maintenanceDate: m.maintenanceDate,
        waterChanged: Value(m.waterChanged),
        attractantReplaced: Value(m.attractantReplaced),
        cleaningDone: Value(m.cleaningDone),
        notes: Value(m.notes),
      ),
    );
  }

  Future<List<Feeding>> allFeedings() => (select(db.feedings)).get();
  Future<List<Harvest>> allHarvests() => (select(db.harvests)).get();
  Future<List<EggCollection>> allEggCollections() => (select(db.eggCollections)).get();
  Future<List<CageMaintenance>> allMaintenances() => (select(db.cageMaintenances)).get();
}
