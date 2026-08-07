import 'package:drift/drift.dart';

class SyncOutboxes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get entityType => text().named('entity_type')();
  TextColumn get entityId => text().named('entity_id').nullable()();
  TextColumn get status => text().withDefault(const Constant('pending'))();
  TextColumn get operation => text().withDefault(const Constant(''))();
  TextColumn get payload => text().withDefault(const Constant(''))();
  IntColumn get retryCount => integer().named('retry_count').withDefault(const Constant(0))();
  TextColumn get errorMessage => text().named('error_message').nullable()();
  DateTimeColumn get createdAt => dateTime().clientDefault(() => DateTime.now())();
  DateTimeColumn get updatedAt => dateTime().clientDefault(() => DateTime.now())();
}
