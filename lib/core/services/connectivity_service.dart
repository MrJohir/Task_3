import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:task_3/core/utils/logging/logger.dart';

/// connectivity service to monitor internet connection
class ConnectivityService extends GetxService {
  static ConnectivityService get instance => Get.put<ConnectivityService>(ConnectivityService());

  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  final RxBool _isConnected = false.obs;
  final RxBool _wasConnected = false.obs;

  /// check if device is connected to internet
  bool get isConnected => _isConnected.value;

  /// check if device was previously connected
  bool get wasConnected => _wasConnected.value;

  /// stream of connectivity status
  Stream<bool> get connectivityStream => _isConnected.stream;

  @override
  Future<void> onInit() async {
    super.onInit();
    await _initConnectivity();
    _startConnectivityListener();
  }

  @override
  void onClose() {
    _connectivitySubscription.cancel();
    super.onClose();
  }

  /// initialize connectivity status
  Future<void> _initConnectivity() async {
    try {
      final result = await _connectivity.checkConnectivity();
      _updateConnectionStatus(result);
    } catch (e) {
      AppLogger.error('Failed to check connectivity: $e');
      _isConnected.value = false;
    }
  }

  /// start listening to connectivity changes
  void _startConnectivityListener() {
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      _updateConnectionStatus,
      onError: (error) {
        AppLogger.error('Connectivity stream error: $error');
        _isConnected.value = false;
      },
    );
  }

  /// update connection status based on connectivity result
  void _updateConnectionStatus(List<ConnectivityResult> results) {
    final bool hasConnection = results.any(
      (result) =>
          result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi ||
          result == ConnectivityResult.ethernet,
    );

    // store previous connection state
    _wasConnected.value = _isConnected.value;

    // update current connection state
    _isConnected.value = hasConnection;

    AppLogger.info(
      'Connectivity changed: ${hasConnection ? 'Connected' : 'Disconnected'}',
    );

    // trigger callbacks based on connection changes
    if (hasConnection && !_wasConnected.value) {
      _onConnected();
    } else if (!hasConnection && _wasConnected.value) {
      _onDisconnected();
    }
  }

  /// callback when device gets connected
  void _onConnected() {
    AppLogger.info('Device connected to internet');
    // notify other services about connection
    if (Get.isRegistered<SyncService>()) {
      Get.find<SyncService>().onConnectivityChanged(true);
    }
  }

  /// callback when device gets disconnected
  void _onDisconnected() {
    AppLogger.info('Device disconnected from internet');
    // notify other services about disconnection
    if (Get.isRegistered<SyncService>()) {
      Get.find<SyncService>().onConnectivityChanged(false);
    }
  }

  /// manually check connectivity
  Future<bool> checkConnectivity() async {
    try {
      final result = await _connectivity.checkConnectivity();
      final hasConnection = result.any(
        (r) =>
            r == ConnectivityResult.mobile ||
            r == ConnectivityResult.wifi ||
            r == ConnectivityResult.ethernet,
      );

      _isConnected.value = hasConnection;
      return hasConnection;
    } catch (e) {
      AppLogger.error('Failed to check connectivity: $e');
      return false;
    }
  }
}

/// sync service to handle offline/online data synchronization
class SyncService extends GetxService {
  static SyncService get instance => Get.find<SyncService>();

  final RxList<String> _pendingSyncItems = <String>[].obs;
  final RxBool _isSyncing = false.obs;

  /// get pending sync items
  List<String> get pendingSyncItems => _pendingSyncItems;

  /// check if currently syncing
  bool get isSyncing => _isSyncing.value;

  @override
  Future<void> onInit() async {
    super.onInit();
    await _loadPendingSyncItems();
  }

  /// load pending sync items from storage
  Future<void> _loadPendingSyncItems() async {
    try {
      // load pending items from local storage
      // this will be implemented when we create the note repository
      AppLogger.info('Loading pending sync items');
    } catch (e) {
      AppLogger.error('Failed to load pending sync items: $e');
    }
  }

  /// handle connectivity changes
  void onConnectivityChanged(bool isConnected) {
    if (isConnected && _pendingSyncItems.isNotEmpty) {
      _syncPendingItems();
    }
  }

  /// add item to sync queue
  void addToSyncQueue(String itemId) {
    if (!_pendingSyncItems.contains(itemId)) {
      _pendingSyncItems.add(itemId);
      AppLogger.info('Added item to sync queue: $itemId');
    }
  }

  /// remove item from sync queue
  void removeFromSyncQueue(String itemId) {
    _pendingSyncItems.remove(itemId);
    AppLogger.info('Removed item from sync queue: $itemId');
  }

  /// sync pending items
  Future<void> _syncPendingItems() async {
    if (_isSyncing.value) return;

    try {
      _isSyncing.value = true;
      AppLogger.info('Starting sync of ${_pendingSyncItems.length} items');

      // sync items one by one
      final itemsToSync = List<String>.from(_pendingSyncItems);
      for (final itemId in itemsToSync) {
        try {
          // sync individual item
          // this will be implemented in the note repository
          await _syncItem(itemId);
          removeFromSyncQueue(itemId);
        } catch (e) {
          AppLogger.error('Failed to sync item $itemId: $e');
          // keep item in queue for retry
        }
      }

      AppLogger.info('Sync completed');
    } catch (e) {
      AppLogger.error('Sync failed: $e');
    } finally {
      _isSyncing.value = false;
    }
  }

  /// sync individual item
  Future<void> _syncItem(String itemId) async {
    // this will be implemented in the note repository
    AppLogger.info('Syncing item: $itemId');
    await Future.delayed(const Duration(milliseconds: 500)); // mock delay
  }

  /// manually trigger sync
  Future<void> syncNow() async {
    if (Get.find<ConnectivityService>().isConnected) {
      await _syncPendingItems();
    } else {
      AppLogger.warning('Cannot sync: No internet connection');
    }
  }
}
