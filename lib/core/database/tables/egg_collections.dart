import 'package:drift/drift.dart';

class EggCollections extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get cageId => text().named('cage_id')();
  TextColumn get eggWeightGrams => text().named('egg_weight_grams').withDefault(const Constant(''))();
  TextColumn get quality => text().withDefault(const Constant('good'))();
  DateTimeColumn get collectedAt => dateTime().named('collected_at')();
  TextColumn get notes => text().nullable()();
  TextColumn get photoUrl => text().named('photo_url').nullable()();
  DateTimeColumn get createdAt => dateTime().clientDefault(() => DateTime.now())();
  DateTimeColumn get updatedAt => dateTime().clientDefault(() => DateTime.now())();
}
