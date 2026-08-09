import 'package:flutter/foundation.dart';
import 'package:flyful_farms/core/database/daos/sync_dao.dart';
import 'package:flyful_farms/core/sync/sync_controller.dart';
import 'package:flyful_farms/core/sync/sync_service.dart';

class SyncProvider extends ChangeNotifier {
  final SyncDao _syncDao;
  final SyncController _controller;

  int _pendingCount = 0;
  bool _loading = false;
  SyncResult? _lastResult;

  SyncProvider(this._syncDao, this._controller) {
    _controller.addListener(notifyListeners);
  }

  int get pendingCount => _pendingCount;
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
      _pendingCount = (await _syncDao.getPendingOperations()).length;
    } catch (_) {
      _pendingCount = 0;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> syncNow() async {
    _lastResult = await _controller.syncNow();
    await loadPending();
  }

  @override
  void dispose() {
    _controller.removeListener(notifyListeners);
    super.dispose();
  }
}