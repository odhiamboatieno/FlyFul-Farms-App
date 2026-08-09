import 'package:flutter/foundation.dart';
import 'package:flyful_farms/core/database/daos/batch_dao.dart';
import 'package:flyful_farms/core/database/daos/cage_dao.dart';
import 'package:flyful_farms/core/database/daos/download_dao.dart';

class FarmProvider extends ChangeNotifier {
  final BatchDao _batchDao;
  final CageDao _cageDao;
  final DownloadDao _downloadDao;

  double _larvaeKg = 0;
  double _frassKg = 0;
  double _pupaKg = 0;
  double _eggGrams = 0;
  int _batchCount = 0;
  int _cageCount = 0;
  int _harvestKgThisWeek = 0;
  int _harvestKgLastWeek = 0;
  bool _loading = false;

  FarmProvider(this._batchDao, this._cageDao, this._downloadDao);

  double get larvaeKg => _larvaeKg;
  double get frassKg => _frassKg;
  double get pupaKg => _pupaKg;
  double get eggGrams => _eggGrams;
  int get batchCount => _batchCount;
  int get cageCount => _cageCount;
  int get harvestKgThisWeek => _harvestKgThisWeek;
  int get harvestKgLastWeek => _harvestKgLastWeek;
  bool get loading => _loading;

  Future<void> load() async {
    _loading = true;
    notifyListeners();
    try {
      final now = DateTime.now();
      final todayStart = DateTime(now.year, now.month, now.day);
      final weekStart = todayStart.subtract(Duration(days: todayStart.weekday - 1));
      final lastWeekStart = weekStart.subtract(const Duration(days: 7));

      final batches = await _batchDao.getAllBatches();
      final cages = await _cageDao.getAllCages();
      final harvests = await _downloadDao.allHarvests();
      final eggCollections = await _downloadDao.allEggCollections();

      _batchCount = batches.length;
      _cageCount = cages.length;

      _larvaeKg = harvests.fold<double>(0, (sum, h) => sum + h.wetLarvaeKg);
      _frassKg = harvests.fold<double>(0, (sum, h) => sum + (h.frassKg ?? 0));
      _pupaKg = harvests.fold<double>(0, (sum, h) => sum + (h.pupaKg ?? 0));
      _eggGrams = eggCollections.fold<double>(
        0,
        (sum, e) => sum + (double.tryParse(e.eggWeightGrams) ?? 0),
      );

      _harvestKgThisWeek = harvests
          .where((h) => !h.harvestedAt.isBefore(weekStart))
          .fold<double>(0, (sum, h) => sum + h.wetLarvaeKg)
          .round();
      _harvestKgLastWeek = harvests
          .where((h) => !h.harvestedAt.isBefore(lastWeekStart) && h.harvestedAt.isBefore(weekStart))
          .fold<double>(0, (sum, h) => sum + h.wetLarvaeKg)
          .round();
    } catch (_) {
      // Leave stats at zero rather than crashing the farm page.
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}
