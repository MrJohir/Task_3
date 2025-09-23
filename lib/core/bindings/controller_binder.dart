import 'package:get/get.dart';
import 'package:task_3/core/services/connectivity_service.dart';
import 'package:task_3/core/services/storage_service.dart';
import 'package:task_3/features/notes/controllers/note_controller.dart';
import 'package:task_3/features/notes/repositories/note_repository.dart';
import 'package:task_3/features/settings/controllers/theme_controller.dart';

/// controller binder for dependency injection
class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    // core services
    Get.put<StorageService>(StorageService(), permanent: true);
    Get.put<ConnectivityService>(ConnectivityService(), permanent: true);
    Get.put<SyncService>(SyncService(), permanent: true);

    // repositories
    Get.put<NoteRepository>(NoteRepository(), permanent: true);

    // controllers
    Get.put<ThemeController>(ThemeController(), permanent: true);
    Get.put<NoteController>(NoteController(), permanent: true);
  }
}
