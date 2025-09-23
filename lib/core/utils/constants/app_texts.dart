/// app text constants for consistent text usage
class AppTexts {
  AppTexts._();

  // app
  static const String appName = 'Notes App';
  static const String appVersion = '1.0.0';

  // common
  static const String save = 'Save';
  static const String cancel = 'Cancel';
  static const String delete = 'Delete';
  static const String edit = 'Edit';
  static const String add = 'Add';
  static const String search = 'Search';
  static const String retry = 'Retry';
  static const String ok = 'OK';
  static const String yes = 'Yes';
  static const String no = 'No';

  // notes
  static const String notes = 'Notes';
  static const String createNote = 'Create Note';
  static const String editNote = 'Edit Note';
  static const String deleteNote = 'Delete Note';
  static const String noteTitle = 'Note Title';
  static const String noteContent = 'Note Content';
  static const String titleHint = 'Enter note title';
  static const String contentHint = 'Start writing your note...';
  static const String noNotes = 'No notes found';
  static const String noNotesSubtitle = 'Tap + to create your first note';
  static const String searchNotes = 'Search notes...';

  // messages
  static const String noteCreated = 'Note created successfully';
  static const String noteUpdated = 'Note updated successfully';
  static const String noteDeleted = 'Note deleted successfully';
  static const String noteSynced = 'Note synced successfully';
  static const String syncFailed = 'Sync failed - will retry when online';
  static const String offline = 'You are offline';
  static const String online = 'You are online';
  static const String networkError = 'Network error occurred';
  static const String unknownError = 'An unknown error occurred';

  // validation
  static const String titleRequired = 'Title is required';
  static const String contentRequired = 'Content is required';
  static const String titleTooShort = 'Title must be at least 3 characters';
  static const String titleTooLong = 'Title must be less than 100 characters';

  // dialogs
  static const String deleteNoteTitle = 'Delete Note';
  static const String deleteNoteMessage =
      'Are you sure you want to delete this note?';
  static const String unsavedChangesTitle = 'Unsaved Changes';
  static const String unsavedChangesMessage =
      'You have unsaved changes. Do you want to save them?';

  // settings
  static const String settings = 'Settings';
  static const String darkMode = 'Dark Mode';
  static const String about = 'About';
  static const String version = 'Version';

  // colors
  static const String selectColor = 'Select Color';
  static const String noteColor = 'Note Color';
}
