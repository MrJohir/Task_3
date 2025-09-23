import 'package:get/get.dart';
import 'package:task_3/features/notes/views/screens/note_editor_screen.dart';
import 'package:task_3/features/notes/views/screens/notes_list_screen.dart';
import 'package:task_3/features/settings/views/screens/settings_screen.dart';

/// app routes configuration
class AppRoutes {
  AppRoutes._();

  // route names
  static const String home = '/';
  static const String notesList = '/notes';
  static const String noteEditor = '/note-editor';
  static const String settings = '/settings';

  // route pages
  static List<GetPage> pages = [
    GetPage(name: home, page: () => const NotesListScreen()),
    GetPage(name: notesList, page: () => const NotesListScreen()),
    GetPage(name: noteEditor, page: () => const NoteEditorScreen()),
    GetPage(name: settings, page: () => const SettingsScreen()),
  ];
}
