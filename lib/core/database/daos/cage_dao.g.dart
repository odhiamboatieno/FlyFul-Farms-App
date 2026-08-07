// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cage_dao.dart';

// ignore_for_file: type=lint
mixin _$CageDaoMixin on DatabaseAccessor<AppDatabase> {
  $BreedingCagesTable get breedingCages => attachedDatabase.breedingCages;
  CageDaoManager get managers => CageDaoManager(this);
}

class CageDaoManager {
  final _$CageDaoMixin _db;
  CageDaoManager(this._db);
  $$BreedingCagesTableTableManager get breedingCages =>
      $$BreedingCagesTableTableManager(_db.attachedDatabase, _db.breedingCages);
}
