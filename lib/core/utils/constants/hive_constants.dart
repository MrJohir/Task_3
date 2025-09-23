/// hive constants for local storage
class HiveConstants {
  HiveConstants._();

  // box names
  static const String notesBox = 'notes_box';
  static const String settingsBox = 'settings_box';
  static const String syncQueueBox = 'sync_queue_box';

  // keys
  static const String isDarkModeKey = 'is_dark_mode';
  static const String lastSyncTimeKey = 'last_sync_time';
  static const String userIdKey = 'user_id';

  // type adapters
  static const int noteTypeId = 0;
  static const int syncQueueItemTypeId = 1;
}
