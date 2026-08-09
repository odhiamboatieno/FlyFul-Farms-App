import 'package:drift/drift.dart';
import 'package:flyful_farms/core/database/app_database.dart';
import 'package:flyful_farms/core/database/tables/cages.dart';

part 'cage_dao.g.dart';

@DriftAccessor(tables: [BreedingCages])
class CageDao extends DatabaseAccessor<AppDatabase> {
  final AppDatabase db;

  CageDao(this.db) : super(db);

  Future<List<BreedingCage>> getAllCages() async {
    return await (select(db.breedingCages)).get();
  }

  Future<BreedingCage?> getCageById(int id) async {
    final rows = await (select(db.breedingCages)..where((t) => t.id.equals(id))).get();
    return rows.isEmpty ? null : rows.first;
  }

  Future<int> insertCage(BreedingCagesCompanion cage) async {
    return await into(db.breedingCages).insert(cage);
  }

  Future<bool> updateCage(BreedingCagesCompanion cage) async {
    return await (update(db.breedingCages)).replace(cage);
  }

  Future<int> deleteCage(int id) async {
    return await (delete(db.breedingCages)..where((t) => t.id.equals(id))).go();
  }
}
