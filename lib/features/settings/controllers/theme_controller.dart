import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_3/core/services/storage_service.dart';
import 'package:task_3/core/utils/constants/hive_constants.dart';
import 'package:task_3/core/utils/logging/logger.dart';

/// theme controller for managing app theme
class ThemeController extends GetxController {
  final StorageService _storageService = StorageService();

  final RxBool _isDarkMode = false.obs;

  /// check if dark mode is enabled
  bool get isDarkMode => _isDarkMode.value;

  /// get current theme mode
  ThemeMode get themeMode =>
      _isDarkMode.value ? ThemeMode.dark : ThemeMode.light;

  @override
  Future<void> onInit() async {
    super.onInit();
    await _loadThemeFromStorage();
  }

  /// load theme preference from storage
  Future<void> _loadThemeFromStorage() async {
    try {
      final isDark = _storageService.getData<bool>(
        key: HiveConstants.isDarkModeKey,
        defaultValue: false,
      );

      _isDarkMode.value = isDark ?? false;
      AppLogger.info(
        'Theme loaded from storage: ${_isDarkMode.value ? 'Dark' : 'Light'}',
      );
    } catch (e) {
      AppLogger.error('Failed to load theme from storage: $e');
      _isDarkMode.value = false;
    }
  }

  /// toggle theme mode
  Future<void> toggleTheme() async {
    try {
      _isDarkMode.value = !_isDarkMode.value;

      await _storageService.saveData(
        key: HiveConstants.isDarkModeKey,
        value: _isDarkMode.value,
      );

      // update system theme
      Get.changeThemeMode(themeMode);

      AppLogger.info(
        'Theme changed to: ${_isDarkMode.value ? 'Dark' : 'Light'}',
      );
    } catch (e) {
      AppLogger.error('Failed to toggle theme: $e');
      // revert change if save failed
      _isDarkMode.value = !_isDarkMode.value;
    }
  }

  /// set theme mode
  Future<void> setThemeMode(bool isDark) async {
    if (_isDarkMode.value == isDark) return;

    try {
      _isDarkMode.value = isDark;

      await _storageService.saveData(
        key: HiveConstants.isDarkModeKey,
        value: _isDarkMode.value,
      );

      // update system theme
      Get.changeThemeMode(themeMode);

      AppLogger.info('Theme set to: ${_isDarkMode.value ? 'Dark' : 'Light'}');
    } catch (e) {
      AppLogger.error('Failed to set theme: $e');
      // revert change if save failed
      _isDarkMode.value = !_isDarkMode.value;
    }
  }
}
