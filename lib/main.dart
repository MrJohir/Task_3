import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:task_3/app.dart';
import 'package:task_3/core/services/storage_service.dart';
import 'package:task_3/core/utils/logging/logger.dart';

/// main entry point of the application
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // initialize core services
  await _initializeServices();

  // configure easy loading
  _configureEasyLoading();

  // set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const NotesApp());
}

/// initialize core services
Future<void> _initializeServices() async {
  try {
    // initialize storage service
    final storageService = StorageService();
    await storageService.init();
    Get.put(storageService, permanent: true);

    AppLogger.info('Core services initialized successfully');
  } catch (e) {
    AppLogger.error('Failed to initialize core services: $e');
    rethrow;
  }
}

/// configure easy loading
void _configureEasyLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.white
    ..backgroundColor = Colors.grey[800]
    ..indicatorColor = Colors.white
    ..textColor = Colors.white
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = false
    ..dismissOnTap = false;
}
