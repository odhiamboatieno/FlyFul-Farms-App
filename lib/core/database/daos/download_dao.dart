import 'package:drift/drift.dart';
import 'package:flyful_farms/core/database/app_database.dart';
import 'package:flyful_farms/core/database/tables/feedings.dart';
import 'package:flyful_farms/core/database/tables/harvests.dart';
import 'package:flyful_farms/core/database/tables/egg_collections.dart';
import 'package:flyful_farms/core/database/tables/maintenance.dart';
import 'package:flyful_farms/core/database/tables/batches.dart';
import 'package:flyful_farms/core/database/tables/cages.dart';

part 'download_dao.g.dart';

@DriftAccessor(tables: [Feedings, Harvests, EggCollections, CageMaintenances, Batches, BreedingCages])
class DownloadDao extends DatabaseAccessor<AppDatabase> {
  final AppDatabase db;

  DownloadDao(this.db) : super(db);

  Future<int> upsertBatch(Batche batch) async {
    final existing = await (select(db.batches)
          ..where((t) => t.remoteId.equals(batch.remoteId!)))
        .getSingleOrNull();
    if (existing != null) {
      await (update(db.batches)..where((t) => t.id.equals(existing.id)))
          .write(batch);
      return existing.id;
    }
    return await insertBatch(BatchesCompanion.insert(
      remoteId: Value(batch.remoteId),
      batchNumber: Value(batch.batchNumber),
      wasteType: Value(batch.wasteType),
      wasteQuantityKg: Value(batch.wasteQuantityKg),
      neonatesAdded: Value(batch.neonatesAdded),
      status: Value(batch.status),
      dayNumber: Value(batch.dayNumber),
      startDate: batch.startDate,
      expectedHarvestDate: batch.expectedHarvestDate,
      actualHarvestDate: Value(batch.actualHarvestDate),
      notes: Value(batch.notes),
      photoUrl: Value(batch.photoUrl),
      latitude: Value(batch.latitude),
      longitude: Value(batch.longitude),
      createdAt: Value(batch.createdAt),
      updatedAt: Value(batch.updatedAt),
    ));
  }

  Future<int> insertBatch(BatchesCompanion companion) {
    return into(db.batches).insert(companion);
  }

  Future<int> upsertBreedingCage(BreedingCage cage) async {
    final existing = await (select(db.breedingCages)
          ..where((t) => t.remoteId.equals(cage.remoteId!)))
        .getSingleOrNull();
    if (existing != null) {
      await (update(db.breedingCages)..where((t) => t.id.equals(existing.id)))
          .write(cage);
      return existing.id;
    }
    return await insertBreedingCage(BreedingCagesCompanion.insert(
      remoteId: Value(cage.remoteId),
      cageNumber: Value(cage.cageNumber),
      status: Value(cage.status),
      ageDays: Value(cage.ageDays),
      pupaLoadedKg: Value(cage.pupaLoadedKg),
      pupaSource: Value(cage.pupaSource),
      breedingDate: Value(cage.breedingDate),
      lastMaintenanceDate: Value(cage.lastMaintenanceDate),
      attractantInstalled: Value(cage.attractantInstalled),
      waterAdded: Value(cage.waterAdded),
      notes: Value(cage.notes),
      createdAt: Value(cage.createdAt),
      updatedAt: Value(cage.updatedAt),
    ));
  }

  Future<int> insertBreedingCage(BreedingCagesCompanion companion) {
    return into(db.breedingCages).insert(companion);
  }

  Future<int> upsertFeeding(Feeding feeding) async {
    final existing = await (select(db.feedings)
          ..where((t) => t.remoteId.equals(feeding.remoteId!)))
        .getSingleOrNull();
    if (existing != null) {
      await (update(db.feedings)..where((t) => t.id.equals(existing.id)))
          .write(feeding);
      return existing.id;
    }
    return await insertFeeding(FeedingsCompanion.insert(
      remoteId: Value(feeding.remoteId),
      batchId: feeding.batchId,
      wasteQuantityKg: feeding.wasteQuantityKg,
      wasteType: feeding.wasteType,
      fedAt: feeding.fedAt,
      notes: Value(feeding.notes),
    ));
  }

  Future<int> insertFeeding(FeedingsCompanion feeding) {
    return into(db.feedings).insert(feeding);
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
    return await insertHarvest(HarvestsCompanion.insert(
      remoteId: Value(harvest.remoteId),
      batchId: harvest.batchId,
      wetLarvaeKg: harvest.wetLarvaeKg,
      frassKg: Value(harvest.frassKg),
      pupaKg: Value(harvest.pupaKg),
      harvestedAt: harvest.harvestedAt,
      notes: Value(harvest.notes),
    ));
  }

  Future<int> insertHarvest(HarvestsCompanion companion) {
    return into(db.harvests).insert(companion);
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
    return await insertEggCollection(EggCollectionsCompanion.insert(
      remoteId: Value(egg.remoteId),
      cageId: egg.cageId,
      eggWeightGrams: Value(egg.eggWeightGrams),
      quality: Value(egg.quality),
      collectedAt: egg.collectedAt,
      notes: Value(egg.notes),
    ));
  }

  Future<int> insertEggCollection(EggCollectionsCompanion companion) {
    return into(db.eggCollections).insert(companion);
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
    return await insertCageMaintenance(CageMaintenancesCompanion.insert(
      remoteId: Value(m.remoteId),
      cageId: m.cageId,
      maintenanceDate: m.maintenanceDate,
      waterChanged: Value(m.waterChanged),
      attractantReplaced: Value(m.attractantReplaced),
      cleaningDone: Value(m.cleaningDone),
      notes: Value(m.notes),
    ));
  }

  Future<int> insertCageMaintenance(CageMaintenancesCompanion companion) {
    return into(db.cageMaintenances).insert(companion);
  }

  Future<List<Feeding>> allFeedings() => (select(db.feedings)).get();
  Future<List<Harvest>> allHarvests() => (select(db.harvests)).get();
  Future<List<EggCollection>> allEggCollections() => (select(db.eggCollections)).get();
  Future<List<CageMaintenance>> allMaintenances() => (select(db.cageMaintenances)).get();

  Future<int> deleteFeeding(int id) => (delete(db.feedings)..where((t) => t.id.equals(id))).go();
  Future<int> deleteHarvest(int id) => (delete(db.harvests)..where((t) => t.id.equals(id))).go();
  Future<int> deleteEggCollection(int id) => (delete(db.eggCollections)..where((t) => t.id.equals(id))).go();
  Future<int> deleteMaintenance(int id) => (delete(db.cageMaintenances)..where((t) => t.id.equals(id))).go();

  Future<List<Feeding>> feedingsForBatch(String batchId) {
    return (select(db.feedings)
          ..where((t) => t.batchId.equals(batchId))
          ..orderBy([(t) => OrderingTerm.desc(t.fedAt)]))
        .get();
  }

  Future<List<Harvest>> harvestsForBatch(String batchId) {
    return (select(db.harvests)
          ..where((t) => t.batchId.equals(batchId))
          ..orderBy([(t) => OrderingTerm.desc(t.harvestedAt)]))
        .get();
  }

  Future<List<EggCollection>> eggCollectionsForCage(String cageId) {
    return (select(db.eggCollections)
          ..where((t) => t.cageId.equals(cageId))
          ..orderBy([(t) => OrderingTerm.desc(t.collectedAt)]))
        .get();
  }

  Future<List<CageMaintenance>> maintenancesForCage(String cageId) {
    return (select(db.cageMaintenances)
          ..where((t) => t.cageId.equals(cageId))
          ..orderBy([(t) => OrderingTerm.desc(t.maintenanceDate)]))
        .get();
  }
}
