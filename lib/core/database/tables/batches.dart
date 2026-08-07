import 'package:drift/drift.dart';

class Batches extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get batchNumber => text().withDefault(const Constant(''))();
  TextColumn get farmerId => text().withDefault(const Constant(''))();
  TextColumn get farmerName => text().withDefault(const Constant(''))();
  TextColumn get wasteType => text().withDefault(const Constant('mixed_waste'))();
  RealColumn get wasteQuantityKg => real().withDefault(const Constant(0.0))();
  IntColumn get neonatesAdded => integer().withDefault(const Constant(0))();
  TextColumn get status => text().withDefault(const Constant('active'))();
  IntColumn get dayNumber => integer().withDefault(const Constant(0))();
  TextColumn get startDate => text()();
  TextColumn get expectedHarvestDate => text().named('expected_harvest_date')();
  TextColumn get actualHarvestDate => text().named('actual_harvest_date').nullable()();
  TextColumn get notes => text().nullable()();
  TextColumn get photoUrl => text().named('photo_url').nullable()();
  RealColumn get latitude => real().nullable()();
  RealColumn get longitude => real().nullable()();
  DateTimeColumn get createdAt => dateTime().clientDefault(() => DateTime.now())();
  DateTimeColumn get updatedAt => dateTime().clientDefault(() => DateTime.now())();
}
