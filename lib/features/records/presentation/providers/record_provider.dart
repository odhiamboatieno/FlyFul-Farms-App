import 'package:flutter/foundation.dart';
import 'package:flyful_farms/core/database/app_database.dart';
import 'package:flyful_farms/core/database/daos/download_dao.dart';

class RecordProvider extends ChangeNotifier {
  final DownloadDao _downloadDao;

  List<Feeding> _feedings = [];
  List<Harvest> _harvests = [];
  List<EggCollection> _eggCollections = [];
  List<CageMaintenance> _maintenances = [];
  bool _loading = false;

  RecordProvider(this._downloadDao);

  List<Feeding> get feedings => List.unmodifiable(_feedings);
  List<Harvest> get harvests => List.unmodifiable(_harvests);
  List<EggCollection> get eggCollections => List.unmodifiable(_eggCollections);
  List<CageMaintenance> get maintenances => List.unmodifiable(_maintenances);
  bool get loading => _loading;

  Future<void> loadBatchRecords(String batchId) async {
    _loading = true;
    notifyListeners();
    try {
      _feedings = await _downloadDao.feedingsForBatch(batchId);
      _harvests = await _downloadDao.harvestsForBatch(batchId);
    } catch (_) {
      _feedings = [];
      _harvests = [];
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> loadCageRecords(String cageId) async {
    _loading = true;
    notifyListeners();
    try {
      _eggCollections = await _downloadDao.eggCollectionsForCage(cageId);
      _maintenances = await _downloadDao.maintenancesForCage(cageId);
    } catch (_) {
      _eggCollections = [];
      _maintenances = [];
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}