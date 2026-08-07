import 'package:drift/drift.dart';
import 'package:flyful_farms/core/database/app_database.dart';
import 'package:flyful_farms/core/database/tables/sync_outbox.dart';

part 'sync_dao.g.dart';

@DriftAccessor(tables: [SyncOutboxes])
class SyncDao extends DatabaseAccessor<AppDatabase> {
  final AppDatabase db;

  SyncDao(this.db) : super(db);

  Future<List<SyncOutboxe>> getPendingOperations() async {
    return await (select(db.syncOutboxes)
          ..where((t) => t.status.equals('pending'))
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .get();
  }

  Future<int> insertSyncOperation(SyncOutboxesCompanion op) async {
    return await into(db.syncOutboxes).insert(op);
  }

  Future<void> markAsComplete(int id) async {
    await (update(db.syncOutboxes)..where((t) => t.id.equals(id))).write(
        SyncOutboxesCompanion(
          status: Value('completed'),
          updatedAt: Value(DateTime.now()),
        ));
  }

  Future<void> markAsFailed(int id, {String? error}) async {
    final current = await retryCountFor(id);
    await (update(db.syncOutboxes)..where((t) => t.id.equals(id))).write(
      SyncOutboxesCompanion(
        status: const Value('failed'),
        retryCount: Value(current + 1),
        errorMessage: Value(error),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<int> deleteSyncOperation(int id) async {
    return await (delete(db.syncOutboxes)..where((t) => t.id.equals(id))).go();
  }

  Future<int> retryCountFor(int id) async {
    final row = await (select(db.syncOutboxes)..where((t) => t.id.equals(id)))
        .getSingleOrNull();
    return row?.retryCount ?? 0;
  }

  Future<SyncOutboxe?> failedOperation(int id) async {
    final row = await (select(db.syncOutboxes)..where((t) => t.id.equals(id)))
        .getSingleOrNull();
    return row;
  }
}
