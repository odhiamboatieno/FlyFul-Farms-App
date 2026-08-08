import 'package:drift/drift.dart';

class Feedings extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get remoteId => text().named('remote_id').nullable()();
  TextColumn get batchId => text().named('batch_id')();
  RealColumn get wasteQuantityKg => real().named('waste_quantity_kg')();
  TextColumn get wasteType => text().named('waste_type')();
  DateTimeColumn get fedAt => dateTime().named('fed_at')();
  TextColumn get notes => text().nullable()();
  TextColumn get photoUrl => text().named('photo_url').nullable()();
  DateTimeColumn get createdAt => dateTime().clientDefault(() => DateTime.now())();
  DateTimeColumn get updatedAt => dateTime().clientDefault(() => DateTime.now())();
}
