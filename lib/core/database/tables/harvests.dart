import 'package:drift/drift.dart';

class Harvests extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get batchId => text().named('batch_id')();
  RealColumn get wetLarvaeKg => real().named('wet_larvae_kg')();
  RealColumn get frassKg => real().named('frass_kg').nullable()();
  RealColumn get pupaKg => real().named('pupa_kg').nullable()();
  DateTimeColumn get harvestedAt => dateTime().named('harvested_at')();
  TextColumn get notes => text().nullable()();
  TextColumn get photoUrl => text().named('photo_url').nullable()();
  DateTimeColumn get createdAt => dateTime().clientDefault(() => DateTime.now())();
  DateTimeColumn get updatedAt => dateTime().clientDefault(() => DateTime.now())();
}
