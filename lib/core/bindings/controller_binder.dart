import 'package:get/get.dart';
import 'package:task_3/core/services/connectivity_service.dart';
import 'package:task_3/features/notes/controllers/note_controller.dart';
import 'package:task_3/core/services/note_repository.dart';
import 'package:task_3/features/settings/controllers/theme_controller.dart';

/// controller binder for dependency injection
class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    // core services (StorageService is already initialized in main.dart)
    Get.lazyPut<ConnectivityService>(() => ConnectivityService(), fenix: true);

    // repositories - initialize after services
    Get.lazyPut<NoteRepository>(() => NoteRepository(), fenix: true);

    // controllers - initialize after repositories
    Get.lazyPut<ThemeController>(() => ThemeController(), fenix: true);
    Get.lazyPut<NoteController>(() => NoteController(), fenix: true);
  }
}
