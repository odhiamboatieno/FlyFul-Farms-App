import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flyful_farms/core/network/connectivity.dart';
import 'package:flyful_farms/core/sync/sync_service.dart';

class SyncController extends ChangeNotifier {
  final SyncService _syncService;
  final NetworkInfo _network;

  StreamSubscription<bool>? _connectivitySub;
  bool _syncing = false;
  DateTime? _lastSyncedAt;
  bool _syncHadError = false;

  SyncController(this._syncService, this._network);

  bool get isSyncing => _syncing;
  DateTime? get lastSyncedAt => _lastSyncedAt;
  bool get hasSyncError => _syncHadError;

  void start() {
    if (_connectivitySub != null) return;
    _connectivitySub = _network.onConnectivityChanged.listen((online) {
      if (online) {
        unawaited(syncNow());
      }
    });
  }

  Future<SyncResult> syncNow() async {
    if (_syncing) return const SyncResult();
    _syncing = true;
    _syncHadError = false;
    notifyListeners();
    try {
      final result = await _syncService.syncNow();
      _lastSyncedAt = DateTime.now();
      _syncHadError = result.failed > 0 || result.conflicts > 0;
      return result;
    } catch (e) {
      _syncHadError = true;
      rethrow;
    } finally {
      _syncing = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _connectivitySub?.cancel();
    super.dispose();
  }
}