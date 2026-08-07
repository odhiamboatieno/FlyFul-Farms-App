import 'package:drift/drift.dart';
import 'package:flyful_farms/core/database/app_database.dart';
import 'package:flyful_farms/core/database/tables/batches.dart';

part 'batch_dao.g.dart';

@DriftAccessor(tables: [Batches])
class BatchDao extends DatabaseAccessor<AppDatabase> {
  final AppDatabase db;

  BatchDao(this.db) : super(db);

  Future<List<Batche>> getAllBatches() async {
    return await (select(db.batches)).get();
  }

  Future<Batche?> getBatchById(int id) async {
    final rows = await (select(db.batches)..where((t) => t.id.equals(id))).get();
    return rows.isEmpty ? null : rows.first;
  }

  Future<int> insertBatch(BatchesCompanion batch) async {
    return await into(db.batches).insert(batch);
  }

  Future<bool> updateBatch(BatchesCompanion batch) async {
    return await (update(db.batches)..where((t) => t.id.equals(batch.id.value))).replace(batch);
  }

  Future<int> deleteBatch(int id) async {
    return await (delete(db.batches)..where((t) => t.id.equals(id))).go();
  }
}
