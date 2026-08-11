import 'package:flutter/foundation.dart';
import 'package:flyful_farms/core/database/daos/download_dao.dart';

class WeekStat {
  final double thisWeek;
  final double lastWeek;

  const WeekStat({required this.thisWeek, required this.lastWeek});

  bool get improved => thisWeek > lastWeek;
  double get percentThisWeek {
    final max = thisWeek > lastWeek ? thisWeek : lastWeek;
    return max > 0 ? (thisWeek / max).clamp(0.0, 1.0) : 0.0;
  }

  double get percentLastWeek {
    final max = thisWeek > lastWeek ? thisWeek : lastWeek;
    return max > 0 ? (lastWeek / max).clamp(0.0, 1.0) : 0.0;
  }

  String formatKg() {
    return '${thisWeek.round()} KG';
  }

  String formatLastKg() => '${lastWeek.round()}';
}

class CompareProvider extends ChangeNotifier {
  final DownloadDao _downloadDao;

  late WeekStat _wasteUsed;
  late WeekStat _larvaeHarvested;
  late WeekStat _frassCollected;
  bool _loading = false;

  CompareProvider(this._downloadDao) {
    _wasteUsed = const WeekStat(thisWeek: 0, lastWeek: 0);
    _larvaeHarvested = const WeekStat(thisWeek: 0, lastWeek: 0);
    _frassCollected = const WeekStat(thisWeek: 0, lastWeek: 0);
  }

  WeekStat get wasteUsed => _wasteUsed;
  WeekStat get larvaeHarvested => _larvaeHarvested;
  WeekStat get frassCollected => _frassCollected;
  bool get loading => _loading;

  bool get overallImproved {
    if (_larvaeHarvested.thisWeek == 0 && _larvaeHarvested.lastWeek == 0) return false;
    return _larvaeHarvested.thisWeek >= _larvaeHarvested.lastWeek;
  }

  Future<void> load() async {
    _loading = true;
    notifyListeners();
    try {
      final now = DateTime.now();
      final todayStart = DateTime(now.year, now.month, now.day);
      final weekStart = todayStart.subtract(Duration(days: todayStart.weekday - 1));
      final lastWeekStart = weekStart.subtract(const Duration(days: 7));

      final feedings = await _downloadDao.allFeedings();
      final harvests = await _downloadDao.allHarvests();

      _wasteUsed = WeekStat(
        thisWeek: _sumThisWeek(feedings.map((f) => f.wasteQuantityKg).toList(),
            feedings.map((f) => f.fedAt).toList(), weekStart),
        lastWeek: _sumLastWeek(feedings.map((f) => f.wasteQuantityKg).toList(),
            feedings.map((f) => f.fedAt).toList(), weekStart, lastWeekStart),
      );

      _larvaeHarvested = WeekStat(
        thisWeek: _sumThisWeek(harvests.map((h) => h.wetLarvaeKg).toList(),
            harvests.map((h) => h.harvestedAt).toList(), weekStart),
        lastWeek: _sumLastWeek(harvests.map((h) => h.wetLarvaeKg).toList(),
            harvests.map((h) => h.harvestedAt).toList(), weekStart, lastWeekStart),
      );

      _frassCollected = WeekStat(
        thisWeek: _sumThisWeek(harvests.map((h) => h.frassKg ?? 0).toList(),
            harvests.map((h) => h.harvestedAt).toList(), weekStart),
        lastWeek: _sumLastWeek(harvests.map((h) => h.frassKg ?? 0).toList(),
            harvests.map((h) => h.harvestedAt).toList(), weekStart, lastWeekStart),
      );
    } catch (_) {
      // Leave stats at zero rather than crashing the compare page.
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  double _sumThisWeek(List<double> values, List<DateTime> dates, DateTime weekStart) {
    double total = 0;
    for (var i = 0; i < values.length; i++) {
      if (!dates[i].isBefore(weekStart)) total += values[i];
    }
    return total;
  }

  double _sumLastWeek(List<double> values, List<DateTime> dates, DateTime weekStart, DateTime lastWeekStart) {
    double total = 0;
    for (var i = 0; i < values.length; i++) {
      if (!dates[i].isBefore(lastWeekStart) && dates[i].isBefore(weekStart)) total += values[i];
    }
    return total;
  }
}
