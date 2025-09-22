/// enums used throughout the application
enum ThemeMode {
  light,
  dark,
  system,
}

enum ConnectionStatus {
  connected,
  disconnected,
  unknown,
}

enum SyncStatus {
  syncing,
  synced,
  failed,
  pending,
}

enum NoteColor {
  red(0),
  orange(1),
  yellow(2),
  green(3),
  blue(4),
  purple(5),
  pink(6),
  grey(7);

  const NoteColor(this.colorIndex);
  final int colorIndex;
}

enum SortType {
  dateNewest,
  dateOldest,
  titleAZ,
  titleZA,
}

enum LoadingState {
  idle,
  loading,
  success,
  error,
}

enum NoteAction {
  create,
  read,
  update,
  delete,
}

enum DatabaseBox {
  notes('notes'),
  syncQueue('sync_queue'),
  settings('settings');

  const DatabaseBox(this.name);
  final String name;
}

enum ApiMethod {
  get,
  post,
  put,
  patch,
  delete,
}

enum ValidationResult {
  valid,
  titleRequired,
  titleTooShort,
  titleTooLong,
  contentRequired,
  contentTooLong,
}

enum FilterType {
  all,
  color,
  date,
}

extension ThemeModeExtension on ThemeMode {
  String get displayName {
    switch (this) {
      case ThemeMode.light:
        return 'Light';
      case ThemeMode.dark:
        return 'Dark';
      case ThemeMode.system:
        return 'System';
    }
  }
}

extension ConnectionStatusExtension on ConnectionStatus {
  bool get isConnected => this == ConnectionStatus.connected;
  bool get isDisconnected => this == ConnectionStatus.disconnected;
  
  String get displayName {
    switch (this) {
      case ConnectionStatus.connected:
        return 'Connected';
      case ConnectionStatus.disconnected:
        return 'Disconnected';
      case ConnectionStatus.unknown:
        return 'Unknown';
    }
  }
}

extension SyncStatusExtension on SyncStatus {
  bool get isSyncing => this == SyncStatus.syncing;
  bool get isSynced => this == SyncStatus.synced;
  bool get isFailed => this == SyncStatus.failed;
  bool get isPending => this == SyncStatus.pending;
  
  String get displayName {
    switch (this) {
      case SyncStatus.syncing:
        return 'Syncing';
      case SyncStatus.synced:
        return 'Synced';
      case SyncStatus.failed:
        return 'Failed';
      case SyncStatus.pending:
        return 'Pending';
    }
  }
}

extension NoteColorExtension on NoteColor {
  String get displayName {
    switch (this) {
      case NoteColor.red:
        return 'Red';
      case NoteColor.orange:
        return 'Orange';
      case NoteColor.yellow:
        return 'Yellow';
      case NoteColor.green:
        return 'Green';
      case NoteColor.blue:
        return 'Blue';
      case NoteColor.purple:
        return 'Purple';
      case NoteColor.pink:
        return 'Pink';
      case NoteColor.grey:
        return 'Grey';
    }
  }
}

extension SortTypeExtension on SortType {
  String get displayName {
    switch (this) {
      case SortType.dateNewest:
        return 'Newest First';
      case SortType.dateOldest:
        return 'Oldest First';
      case SortType.titleAZ:
        return 'A to Z';
      case SortType.titleZA:
        return 'Z to A';
    }
  }
}