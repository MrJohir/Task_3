import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_3/core/utils/constants/hive_constants.dart';
import 'package:task_3/core/utils/logging/logger.dart';

/// local storage service using hive
class StorageService {
  static final StorageService _instance = StorageService._internal();
  factory StorageService() => _instance;
  StorageService._internal();

  late Box _settingsBox;
  bool _isInitialized = false;

  /// initialize storage service
  Future<void> init() async {
    if (_isInitialized) return;

    try {
      await Hive.initFlutter();

      // open settings box
      _settingsBox = await Hive.openBox(HiveConstants.settingsBox);

      _isInitialized = true;
      AppLogger.info('Storage service initialized successfully');
    } catch (e) {
      AppLogger.error('Failed to initialize storage service: $e');
      rethrow;
    }
  }

  /// save data to storage
  Future<void> saveData({
    required String key,
    required dynamic value,
    String? boxName,
  }) async {
    try {
      if (boxName != null) {
        final box = await Hive.openBox(boxName);
        await box.put(key, value);
      } else {
        await _settingsBox.put(key, value);
      }

      AppLogger.info('Data saved successfully: $key');
    } catch (e) {
      AppLogger.error('Failed to save data: $e');
      rethrow;
    }
  }

  /// get data from storage
  T? getData<T>({required String key, String? boxName, T? defaultValue}) {
    try {
      if (boxName != null) {
        if (Hive.isBoxOpen(boxName)) {
          final box = Hive.box(boxName);
          return box.get(key, defaultValue: defaultValue);
        } else {
          AppLogger.warning('Box $boxName is not open');
          return defaultValue;
        }
      } else {
        return _settingsBox.get(key, defaultValue: defaultValue);
      }
    } catch (e) {
      AppLogger.error('Failed to get data: $e');
      return defaultValue;
    }
  }

  /// remove data from storage
  Future<void> removeData({required String key, String? boxName}) async {
    try {
      if (boxName != null) {
        final box = await Hive.openBox(boxName);
        await box.delete(key);
      } else {
        await _settingsBox.delete(key);
      }

      AppLogger.info('Data removed successfully: $key');
    } catch (e) {
      AppLogger.error('Failed to remove data: $e');
      rethrow;
    }
  }

  /// clear all data from a box
  Future<void> clearBox({String? boxName}) async {
    try {
      if (boxName != null) {
        final box = await Hive.openBox(boxName);
        await box.clear();
      } else {
        await _settingsBox.clear();
      }

      AppLogger.info('Box cleared successfully: ${boxName ?? 'settings'}');
    } catch (e) {
      AppLogger.error('Failed to clear box: $e');
      rethrow;
    }
  }

  /// check if key exists
  bool hasData({required String key, String? boxName}) {
    try {
      if (boxName != null) {
        if (Hive.isBoxOpen(boxName)) {
          final box = Hive.box(boxName);
          return box.containsKey(key);
        } else {
          return false;
        }
      } else {
        return _settingsBox.containsKey(key);
      }
    } catch (e) {
      AppLogger.error('Failed to check data existence: $e');
      return false;
    }
  }

  /// get all keys from a box
  List<String> getAllKeys({String? boxName}) {
    try {
      if (boxName != null) {
        if (Hive.isBoxOpen(boxName)) {
          final box = Hive.box(boxName);
          return box.keys.cast<String>().toList();
        } else {
          return [];
        }
      } else {
        return _settingsBox.keys.cast<String>().toList();
      }
    } catch (e) {
      AppLogger.error('Failed to get all keys: $e');
      return [];
    }
  }

  /// close all boxes
  Future<void> closeAll() async {
    try {
      await Hive.close();
      _isInitialized = false;
      AppLogger.info('All storage boxes closed');
    } catch (e) {
      AppLogger.error('Failed to close storage boxes: $e');
    }
  }
}
