/// app texts class for managing all static texts used in the application
class AppTexts {
  // app info
  static const String appName = 'Notes App';
  static const String appDescription = 'A professional note-taking app with offline sync';
  
  // general texts
  static const String loading = 'Loading...';
  static const String retry = 'Retry';
  static const String cancel = 'Cancel';
  static const String ok = 'OK';
  static const String yes = 'Yes';
  static const String no = 'No';
  static const String save = 'Save';
  static const String delete = 'Delete';
  static const String edit = 'Edit';
  static const String add = 'Add';
  static const String search = 'Search';
  static const String filter = 'Filter';
  static const String sort = 'Sort';
  static const String settings = 'Settings';
  static const String back = 'Back';
  static const String next = 'Next';
  static const String previous = 'Previous';
  static const String done = 'Done';
  static const String create = 'Create';
  static const String update = 'Update';
  
  // notes related
  static const String notes = 'Notes';
  static const String note = 'Note';
  static const String myNotes = 'My Notes';
  static const String newNote = 'New Note';
  static const String editNote = 'Edit Note';
  static const String noteTitle = 'Note Title';
  static const String noteContent = 'Note Content';
  static const String noteCreated = 'Note created successfully';
  static const String noteUpdated = 'Note updated successfully';
  static const String noteDeleted = 'Note deleted successfully';
  static const String noteSaved = 'Note saved successfully';
  static const String deletingNote = 'Deleting note...';
  static const String savingNote = 'Saving note...';
  static const String syncingNote = 'Syncing note...';
  static const String noteColor = 'Note Color';
  static const String selectColor = 'Select Color';
  
  // search and filter
  static const String searchNotes = 'Search notes...';
  static const String searchHint = 'Search by title or content';
  static const String noNotesFound = 'No notes found';
  static const String noSearchResults = 'No search results found';
  static const String filterByColor = 'Filter by color';
  static const String allNotes = 'All Notes';
  static const String sortByDate = 'Sort by date';
  static const String sortByTitle = 'Sort by title';
  static const String sortNewestFirst = 'Newest first';
  static const String sortOldestFirst = 'Oldest first';
  static const String sortAZ = 'A to Z';
  static const String sortZA = 'Z to A';
  
  // validation messages
  static const String titleRequired = 'Title is required';
  static const String contentRequired = 'Content is required';
  static const String titleTooShort = 'Title must be at least 1 character';
  static const String titleTooLong = 'Title must be less than 100 characters';
  static const String contentTooLong = 'Content must be less than 10000 characters';
  
  // error messages
  static const String errorOccurred = 'An error occurred';
  static const String networkError = 'Network error occurred';
  static const String connectionFailed = 'Connection failed';
  static const String syncFailed = 'Sync failed';
  static const String loadingFailed = 'Failed to load data';
  static const String savingFailed = 'Failed to save note';
  static const String deletingFailed = 'Failed to delete note';
  static const String noInternetConnection = 'No internet connection';
  static const String serverError = 'Server error occurred';
  static const String unexpectedError = 'Unexpected error occurred';
  static const String tryAgainLater = 'Please try again later';
  
  // success messages
  static const String syncSuccessful = 'Sync successful';
  static const String dataLoaded = 'Data loaded successfully';
  static const String operationSuccessful = 'Operation completed successfully';
  
  // offline messages
  static const String offlineMode = 'Offline mode';
  static const String offlineMessage = 'You are currently offline';
  static const String willSyncWhenOnline = 'Changes will sync when back online';
  static const String backOnline = 'Back online';
  static const String syncingPendingChanges = 'Syncing pending changes...';
  
  // settings
  static const String theme = 'Theme';
  static const String darkMode = 'Dark Mode';
  static const String lightMode = 'Light Mode';
  static const String systemTheme = 'System Theme';
  static const String about = 'About';
  static const String version = 'Version';
  static const String privacyPolicy = 'Privacy Policy';
  static const String termsOfService = 'Terms of Service';
  
  // dialogs
  static const String confirmDelete = 'Confirm Delete';
  static const String deleteNoteMessage = 'Are you sure you want to delete this note?';
  static const String discardChanges = 'Discard Changes';
  static const String discardChangesMessage = 'You have unsaved changes. Do you want to discard them?';
  static const String exitApp = 'Exit App';
  static const String exitAppMessage = 'Are you sure you want to exit the app?';
  
  // empty states
  static const String noNotesYet = 'No notes yet';
  static const String startCreatingNotes = 'Start creating your first note';
  static const String tapToCreateNote = 'Tap the + button to create a new note';
  
  // date and time
  static const String today = 'Today';
  static const String yesterday = 'Yesterday';
  static const String thisWeek = 'This week';
  static const String thisMonth = 'This month';
  static const String older = 'Older';
  
  // accessibility
  static const String addNoteButton = 'Add new note button';
  static const String searchButton = 'Search button';
  static const String menuButton = 'Menu button';
  static const String backButton = 'Back button';
  static const String deleteButton = 'Delete button';
  static const String editButton = 'Edit button';
  static const String saveButton = 'Save button';
}