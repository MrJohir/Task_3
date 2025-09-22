import 'package:get/get.dart';
// import '../../features/notes/presentation/controllers/note_controller.dart';
import '../services/storage_service.dart';

/// controller binder for dependency injection using GetX
class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    // initialize storage service
    Get.putAsync(() => StorageService.getInstance());
    
    // register note controller
    // Get.lazyPut<NoteController>(() => NoteController(), fenix: true);
    
    // register additional controllers here
  }
}