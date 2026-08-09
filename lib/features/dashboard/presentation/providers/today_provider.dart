import 'package:flutter/foundation.dart';
import 'package:flyful_farms/core/database/daos/batch_dao.dart';
import 'package:flyful_farms/core/database/daos/cage_dao.dart';
import 'package:flyful_farms/core/database/daos/download_dao.dart';

class TodayProvider extends ChangeNotifier {
  final BatchDao _batchDao;
  final CageDao _cageDao;
  final DownloadDao _downloadDao;

  int _activeBatchCount = 0;
  int _cageCount = 0;
  int _feedingsToday = 0;
  int _harvestsToday = 0;
  int _maintenancesToday = 0;
  int _harvestKgThisWeek = 0;
  int _harvestKgLastWeek = 0;
  String? _nextBatchName;
  String? _nextCageName;
  bool _loading = false;

  TodayProvider(this._batchDao, this._cageDao, this._downloadDao);

  int get activeBatchCount => _activeBatchCount;
  int get cageCount => _cageCount;
  int get feedingsToday => _feedingsToday;
  int get harvestsToday => _harvestsToday;
  int get maintenancesToday => _maintenancesToday;
  int get harvestKgThisWeek => _harvestKgThisWeek;
  int get harvestKgLastWeek => _harvestKgLastWeek;
  String? get nextBatchName => _nextBatchName;
  String? get nextCageName => _nextCageName;
  bool get loading => _loading;

  int get jobsToday => _feedingsToday + _harvestsToday + _maintenancesToday;

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
      final feedings = await _downloadDao.allFeedings();
      final harvests = await _downloadDao.allHarvests();
      final maintenances = await _downloadDao.allMaintenances();

      _activeBatchCount = batches.where((b) => b.status == 'active').length;
      _cageCount = cages.length;

      _feedingsToday = feedings.where((f) => !f.fedAt.isBefore(todayStart)).length;
      _harvestsToday = harvests.where((h) => !h.harvestedAt.isBefore(todayStart)).length;
      _maintenancesToday =
          maintenances.where((m) => !m.maintenanceDate.isBefore(todayStart)).length;

      _harvestKgThisWeek = harvests
          .where((h) => !h.harvestedAt.isBefore(weekStart))
          .fold<double>(0, (sum, h) => sum + h.wetLarvaeKg)
          .round();
      _harvestKgLastWeek = harvests
          .where((h) => !h.harvestedAt.isBefore(lastWeekStart) && h.harvestedAt.isBefore(weekStart))
          .fold<double>(0, (sum, h) => sum + h.wetLarvaeKg)
          .round();

      if (batches.isNotEmpty) {
        _nextBatchName = batches.firstWhere(
          (b) => b.status == 'active',
          orElse: () => batches.first,
        ).batchNumber;
      } else {
        _nextBatchName = null;
      }

      if (cages.isNotEmpty) {
        _nextCageName = cages.firstWhere(
          (c) => c.status == 'active',
          orElse: () => cages.first,
        ).cageNumber;
      } else {
        _nextCageName = null;
      }
    } catch (_) {
      // Leave counts at zero rather than crashing the home screen.
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}
