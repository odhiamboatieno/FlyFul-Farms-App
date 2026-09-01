import 'package:flutter/foundation.dart';
import 'package:flyful_farms/core/database/app_database.dart';
import 'package:flyful_farms/core/database/daos/sync_dao.dart';
import 'package:flyful_farms/core/sync/sync_controller.dart';
import 'package:flyful_farms/core/sync/sync_service.dart';

class SyncProvider extends ChangeNotifier {
  final SyncDao _syncDao;
  final SyncController _controller;
  final Future<void> Function() _refreshData;

  List<SyncOutboxe> _pending = [];
  List<Map<String, dynamic>> _conflicts = [];
  bool _loading = false;
  SyncResult? _lastResult;

  SyncProvider(this._syncDao, this._controller, {Future<void> Function()? refreshData})
      : _refreshData = refreshData ?? _noop {
    _controller.addListener(notifyListeners);
  }

  static Future<void> _noop() async {}

  List<SyncOutboxe> get pendingOperations => _pending;
  int get pendingCount => _pending.length;
  List<Map<String, dynamic>> get conflicts => _conflicts;
  bool get hasConflicts => _conflicts.isNotEmpty;
  bool get loading => _loading;
  bool get isSyncing => _controller.isSyncing;
  DateTime? get lastSyncedAt => _controller.lastSyncedAt;
  bool get hasSyncError => _controller.hasSyncError;
  int get lastDownloaded => _controller.lastDownloaded;
  SyncResult? get lastResult => _lastResult;

  Future<void> loadPending() async {
    _loading = true;
    notifyListeners();
    try {
      _pending = await _syncDao.getPendingOperations();
    } catch (_) {
      _pending = [];
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> loadConflicts() async {
    try {
      _conflicts = await _controller.fetchConflicts();
    } catch (_) {
      _conflicts = [];
    }
    notifyListeners();
  }

  Future<bool> resolveConflict(String conflictId, String resolution) async {
    final ok = await _controller.resolveConflict(conflictId, resolution);
    if (ok) {
      await loadConflicts();
      await loadPending();
    }
    return ok;
  }

  Future<void> syncNow() async {
    _lastResult = await _controller.syncNow();
    await loadPending();
    await loadConflicts();
    await _refreshData();
  }

  @override
  void dispose() {
    _controller.removeListener(notifyListeners);
    super.dispose();
  }
}