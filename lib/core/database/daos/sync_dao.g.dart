// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sync_dao.dart';

// ignore_for_file: type=lint
mixin _$SyncDaoMixin on DatabaseAccessor<AppDatabase> {
  $SyncOutboxesTable get syncOutboxes => attachedDatabase.syncOutboxes;
  SyncDaoManager get managers => SyncDaoManager(this);
}

class SyncDaoManager {
  final _$SyncDaoMixin _db;
  SyncDaoManager(this._db);
  $$SyncOutboxesTableTableManager get syncOutboxes =>
      $$SyncOutboxesTableTableManager(_db.attachedDatabase, _db.syncOutboxes);
}
