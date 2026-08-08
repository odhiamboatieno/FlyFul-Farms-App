import 'package:drift/drift.dart';

class CageMaintenances extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get remoteId => text().named('remote_id').nullable()();
  TextColumn get cageId => text().named('cage_id')();
  DateTimeColumn get maintenanceDate => dateTime().named('maintenance_date')();
  BoolColumn get waterChanged => boolean().named('water_changed').withDefault(const Constant(false))();
  BoolColumn get attractantReplaced => boolean().named('attractant_replaced').withDefault(const Constant(false))();
  BoolColumn get cleaningDone => boolean().named('cleaning_done').withDefault(const Constant(false))();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime().clientDefault(() => DateTime.now())();
  DateTimeColumn get updatedAt => dateTime().clientDefault(() => DateTime.now())();
}
