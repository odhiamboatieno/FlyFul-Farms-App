import 'package:drift/drift.dart';

class BreedingCages extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get cageNumber => text().withDefault(const Constant(''))();
  TextColumn get farmerId => text().withDefault(const Constant(''))();
  TextColumn get status => text().withDefault(const Constant('active'))();
  IntColumn get ageDays => integer().named('age_days').withDefault(const Constant(0))();
  RealColumn get pupaLoadedKg => real().named('pupa_loaded_kg').withDefault(const Constant(0.0))();
  TextColumn get pupaSource => text().named('pupa_source').nullable()();
  DateTimeColumn get breedingDate => dateTime().named('breeding_date').nullable()();
  DateTimeColumn get lastMaintenanceDate => dateTime().named('last_maintenance_date').nullable()();
  BoolColumn get attractantInstalled => boolean().named('attractant_installed').withDefault(const Constant(false))();
  BoolColumn get waterAdded => boolean().named('water_added').withDefault(const Constant(false))();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime().clientDefault(() => DateTime.now())();
  DateTimeColumn get updatedAt => dateTime().clientDefault(() => DateTime.now())();
}
