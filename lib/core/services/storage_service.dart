import 'package:shared_preferences/shared_preferences.dart';
import '../utils/logging/logger.dart';

/// storage service for managing local key-value storage using SharedPreferences
class StorageService {
  static StorageService? _instance;
  static SharedPreferences? _preferences;

  static Future<StorageService> getInstance() async {
    _instance ??= StorageService._();
    _preferences ??= await SharedPreferences.getInstance();
    return _instance!;
  }

  StorageService._();

  /// save string value
  /// [key] - Storage key
  /// [value] - String value to save
  /// Returns: true if successful
  Future<bool> setString(String key, String value) async {
    try {
      AppLogger.database('SET STRING', 'SharedPreferences', '$key: $value');
      return await _preferences!.setString(key, value);
    } catch (error, stackTrace) {
      AppLogger.error('Failed to save string: $key', error, stackTrace);
      return false;
    }
  }

  /// get string value
  /// [key] - Storage key
  /// [defaultValue] - Default value if key not found
  /// Returns: String value or default
  String? getString(String key, {String? defaultValue}) {
    try {
      final value = _preferences!.getString(key) ?? defaultValue;
      AppLogger.database('GET STRING', 'SharedPreferences', '$key: $value');
      return value;
    } catch (error, stackTrace) {
      AppLogger.error('Failed to get string: $key', error, stackTrace);
      return defaultValue;
    }
  }

  /// save integer value
  /// [key] - Storage key
  /// [value] - Integer value to save
  /// Returns: true if successful
  Future<bool> setInt(String key, int value) async {
    try {
      AppLogger.database('SET INT', 'SharedPreferences', '$key: $value');
      return await _preferences!.setInt(key, value);
    } catch (error, stackTrace) {
      AppLogger.error('Failed to save int: $key', error, stackTrace);
      return false;
    }
  }

  /// get integer value
  /// [key] - Storage key
  /// [defaultValue] - Default value if key not found
  /// Returns: Integer value or default
  int? getInt(String key, {int? defaultValue}) {
    try {
      final value = _preferences!.getInt(key) ?? defaultValue;
      AppLogger.database('GET INT', 'SharedPreferences', '$key: $value');
      return value;
    } catch (error, stackTrace) {
      AppLogger.error('Failed to get int: $key', error, stackTrace);
      return defaultValue;
    }
  }

  /// save boolean value
  /// [key] - Storage key
  /// [value] - Boolean value to save
  /// Returns: true if successful
  Future<bool> setBool(String key, bool value) async {
    try {
      AppLogger.database('SET BOOL', 'SharedPreferences', '$key: $value');
      return await _preferences!.setBool(key, value);
    } catch (error, stackTrace) {
      AppLogger.error('Failed to save bool: $key', error, stackTrace);
      return false;
    }
  }

  /// get boolean value
  /// [key] - Storage key
  /// [defaultValue] - Default value if key not found
  /// Returns: Boolean value or default
  bool? getBool(String key, {bool? defaultValue}) {
    try {
      final value = _preferences!.getBool(key) ?? defaultValue;
      AppLogger.database('GET BOOL', 'SharedPreferences', '$key: $value');
      return value;
    } catch (error, stackTrace) {
      AppLogger.error('Failed to get bool: $key', error, stackTrace);
      return defaultValue;
    }
  }

  /// save double value
  /// [key] - Storage key
  /// [value] - Double value to save
  /// Returns: true if successful
  Future<bool> setDouble(String key, double value) async {
    try {
      AppLogger.database('SET DOUBLE', 'SharedPreferences', '$key: $value');
      return await _preferences!.setDouble(key, value);
    } catch (error, stackTrace) {
      AppLogger.error('Failed to save double: $key', error, stackTrace);
      return false;
    }
  }

  /// get double value
  /// [key] - Storage key
  /// [defaultValue] - Default value if key not found
  /// Returns: Double value or default
  double? getDouble(String key, {double? defaultValue}) {
    try {
      final value = _preferences!.getDouble(key) ?? defaultValue;
      AppLogger.database('GET DOUBLE', 'SharedPreferences', '$key: $value');
      return value;
    } catch (error, stackTrace) {
      AppLogger.error('Failed to get double: $key', error, stackTrace);
      return defaultValue;
    }
  }

  /// save string list
  /// [key] - Storage key
  /// [value] - List of strings to save
  /// Returns: true if successful
  Future<bool> setStringList(String key, List<String> value) async {
    try {
      AppLogger.database('SET STRING LIST', 'SharedPreferences', '$key: $value');
      return await _preferences!.setStringList(key, value);
    } catch (error, stackTrace) {
      AppLogger.error('Failed to save string list: $key', error, stackTrace);
      return false;
    }
  }

  /// get string list
  /// [key] - Storage key
  /// [defaultValue] - Default value if key not found
  /// Returns: List of strings or default
  List<String>? getStringList(String key, {List<String>? defaultValue}) {
    try {
      final value = _preferences!.getStringList(key) ?? defaultValue;
      AppLogger.database('GET STRING LIST', 'SharedPreferences', '$key: $value');
      return value;
    } catch (error, stackTrace) {
      AppLogger.error('Failed to get string list: $key', error, stackTrace);
      return defaultValue;
    }
  }

  /// check if key exists
  /// [key] - Storage key
  /// Returns: true if key exists
  bool containsKey(String key) {
    try {
      final exists = _preferences!.containsKey(key);
      AppLogger.database('CONTAINS KEY', 'SharedPreferences', '$key: $exists');
      return exists;
    } catch (error, stackTrace) {
      AppLogger.error('Failed to check key: $key', error, stackTrace);
      return false;
    }
  }

  /// remove specific key
  /// [key] - Storage key to remove
  /// Returns: true if successful
  Future<bool> remove(String key) async {
    try {
      AppLogger.database('REMOVE', 'SharedPreferences', key);
      return await _preferences!.remove(key);
    } catch (error, stackTrace) {
      AppLogger.error('Failed to remove key: $key', error, stackTrace);
      return false;
    }
  }

  /// clear all data
  /// Returns: true if successful
  Future<bool> clear() async {
    try {
      AppLogger.database('CLEAR ALL', 'SharedPreferences', 'Clearing all data');
      return await _preferences!.clear();
    } catch (error, stackTrace) {
      AppLogger.error('Failed to clear all data', error, stackTrace);
      return false;
    }
  }

  /// get all keys
  /// Returns: Set of all keys
  Set<String> getKeys() {
    try {
      final keys = _preferences!.getKeys();
      AppLogger.database('GET KEYS', 'SharedPreferences', keys);
      return keys;
    } catch (error, stackTrace) {
      AppLogger.error('Failed to get keys', error, stackTrace);
      return <String>{};
    }
  }

  /// reload preferences from storage
  /// Returns: true if successful
  Future<bool> reload() async {
    try {
      AppLogger.database('RELOAD', 'SharedPreferences', 'Reloading preferences');
      await _preferences!.reload();
      return true;
    } catch (error, stackTrace) {
      AppLogger.error('Failed to reload preferences', error, stackTrace);
      return false;
    }
  }
}

/// storage keys used throughout the app
class StorageKeys {
  // theme settings
  static const String themeMode = 'theme_mode';
  static const String isDarkMode = 'is_dark_mode';
  
  // user preferences
  static const String defaultNoteColor = 'default_note_color';
  static const String sortType = 'sort_type';
  static const String lastSync = 'last_sync';
  
  // app settings
  static const String isFirstLaunch = 'is_first_launch';
  static const String appVersion = 'app_version';
  
  // sync settings
  static const String autoSync = 'auto_sync';
  static const String syncOnWifiOnly = 'sync_on_wifi_only';
  
  // offline data
  static const String pendingSyncCount = 'pending_sync_count';
  static const String lastOfflineTime = 'last_offline_time';
}