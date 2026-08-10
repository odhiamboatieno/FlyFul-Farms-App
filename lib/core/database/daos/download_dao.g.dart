// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'download_dao.dart';

// ignore_for_file: type=lint
mixin _$DownloadDaoMixin on DatabaseAccessor<AppDatabase> {
  $FeedingsTable get feedings => attachedDatabase.feedings;
  $HarvestsTable get harvests => attachedDatabase.harvests;
  $EggCollectionsTable get eggCollections => attachedDatabase.eggCollections;
  $CageMaintenancesTable get cageMaintenances =>
      attachedDatabase.cageMaintenances;
  $BatchesTable get batches => attachedDatabase.batches;
  $BreedingCagesTable get breedingCages => attachedDatabase.breedingCages;
  DownloadDaoManager get managers => DownloadDaoManager(this);
}

class DownloadDaoManager {
  final _$DownloadDaoMixin _db;
  DownloadDaoManager(this._db);
  $$FeedingsTableTableManager get feedings =>
      $$FeedingsTableTableManager(_db.attachedDatabase, _db.feedings);
  $$HarvestsTableTableManager get harvests =>
      $$HarvestsTableTableManager(_db.attachedDatabase, _db.harvests);
  $$EggCollectionsTableTableManager get eggCollections =>
      $$EggCollectionsTableTableManager(
        _db.attachedDatabase,
        _db.eggCollections,
      );
  $$CageMaintenancesTableTableManager get cageMaintenances =>
      $$CageMaintenancesTableTableManager(
        _db.attachedDatabase,
        _db.cageMaintenances,
      );
  $$BatchesTableTableManager get batches =>
      $$BatchesTableTableManager(_db.attachedDatabase, _db.batches);
  $$BreedingCagesTableTableManager get breedingCages =>
      $$BreedingCagesTableTableManager(_db.attachedDatabase, _db.breedingCages);
}
