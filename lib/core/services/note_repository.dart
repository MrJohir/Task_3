import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_3/core/services/network_caller.dart';
import 'package:task_3/core/utils/constants/api_constants.dart';
import 'package:task_3/core/utils/constants/hive_constants.dart';
import 'package:task_3/core/utils/logging/logger.dart';
import 'package:task_3/features/notes/models/note_model.dart';

/// repository for note local data operations
class NoteRepository {
  late Box<NoteModel> _notesBox;
  final NetworkCaller _networkCaller = NetworkCaller();
  bool _isInitialized = false;

  /// initialize repository
  Future<void> init() async {
    if (_isInitialized) return;

    try {
      // register adapter if not already registered
      if (!Hive.isAdapterRegistered(HiveConstants.noteTypeId)) {
        Hive.registerAdapter(NoteModelAdapter());
      }

      _notesBox = await Hive.openBox<NoteModel>(HiveConstants.notesBox);
      _isInitialized = true;
      AppLogger.info('Note repository initialized successfully');
    } catch (e) {
      AppLogger.error('Failed to initialize note repository: $e');
      rethrow;
    }
  }

  /// get all notes from local storage
  Future<List<NoteModel>> getAllNotes() async {
    try {
      if (!_isInitialized) await init();

      final notes = _notesBox.values.where((note) => !note.isDeleted).toList()
        ..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));

      AppLogger.info('Retrieved ${notes.length} notes from local storage');
      return notes;
    } catch (e) {
      AppLogger.error('Failed to get all notes: $e');
      rethrow;
    }
  }

  /// get note by id
  Future<NoteModel?> getNoteById(String id) async {
    try {
      if (!_isInitialized) await init();

      final note = _notesBox.values.firstWhere(
        (note) => note.id == id && !note.isDeleted,
        orElse: () => throw Exception('Note not found'),
      );

      AppLogger.info('Retrieved note by id: $id');
      return note;
    } catch (e) {
      AppLogger.error('Failed to get note by id: $e');
      return null;
    }
  }

  /// search notes by query
  Future<List<NoteModel>> searchNotes(String query) async {
    try {
      if (!_isInitialized) await init();

      final lowercaseQuery = query.toLowerCase();
      final notes =
          _notesBox.values
              .where(
                (note) =>
                    !note.isDeleted &&
                    (note.title.toLowerCase().contains(lowercaseQuery) ||
                        note.content.toLowerCase().contains(lowercaseQuery)),
              )
              .toList()
            ..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));

      AppLogger.info('Found ${notes.length} notes for query: $query');
      return notes;
    } catch (e) {
      AppLogger.error('Failed to search notes: $e');
      rethrow;
    }
  }

  /// create new note
  Future<void> createNote(NoteModel note) async {
    try {
      if (!_isInitialized) await init();

      await _notesBox.put(note.id, note);
      AppLogger.info('Note created locally: ${note.id}');

      // attempt to sync with server if connected
      await _syncNoteWithServer(note);
    } catch (e) {
      AppLogger.error('Failed to create note: $e');
      rethrow;
    }
  }

  /// update existing note
  Future<void> updateNote(NoteModel note) async {
    try {
      if (!_isInitialized) await init();

      // mark as unsynced since it's been modified
      final unsyncedNote = note.markAsUnsynced();
      await _notesBox.put(note.id, unsyncedNote);
      AppLogger.info('Note updated locally: ${note.id}');

      // attempt to sync with server if connected
      await _syncNoteWithServer(unsyncedNote);
    } catch (e) {
      AppLogger.error('Failed to update note: $e');
      rethrow;
    }
  }

  /// delete note
  Future<void> deleteNote(String id) async {
    try {
      if (!_isInitialized) await init();

      final note = await getNoteById(id);
      if (note == null) {
        throw Exception('Note not found');
      }

      // mark as deleted instead of actually deleting
      final deletedNote = note.markAsDeleted();
      await _notesBox.put(id, deletedNote);
      AppLogger.info('Note marked as deleted: $id');

      // if synced with server, we could implement server deletion here
      // for now, we just mark as deleted locally
    } catch (e) {
      AppLogger.error('Failed to delete note: $e');
      rethrow;
    }
  }

  /// sync note with server
  Future<void> _syncNoteWithServer(NoteModel note) async {
    try {
      // check if connected to internet
      // Note: We'll check connectivity directly to avoid circular dependency

      // sync with jsonplaceholder API
      final response = await _networkCaller.post(
        endpoint: ApiConstants.posts,
        body: note.toApiJson(),
      );

      if (response['id'] != null) {
        // mark note as synced with server id
        final syncedNote = note.markAsSynced(response['id']);
        await _notesBox.put(note.id, syncedNote);
        AppLogger.info(
          'Note synced with server: ${note.id}, server id: ${response['id']}',
        );
      }
    } catch (e) {
      AppLogger.error('Failed to sync note with server: $e');
      // note remains unsynced and will be retried later
    }
  }

  /// sync all pending notes
  Future<void> syncPendingNotes() async {
    try {
      if (!_isInitialized) await init();

      final pendingNotes = _notesBox.values
          .where((note) => !note.isSynced && !note.isDeleted)
          .toList();

      AppLogger.info('Syncing ${pendingNotes.length} pending notes');

      for (final note in pendingNotes) {
        await _syncNoteWithServer(note);
        // add small delay to avoid overwhelming the server
        await Future.delayed(const Duration(milliseconds: 100));
      }

      AppLogger.info('Completed syncing pending notes');
    } catch (e) {
      AppLogger.error('Failed to sync pending notes: $e');
      rethrow;
    }
  }

  /// get sync status
  Future<Map<String, dynamic>> getSyncStatus() async {
    try {
      if (!_isInitialized) await init();

      final allNotes = _notesBox.values
          .where((note) => !note.isDeleted)
          .toList();
      final syncedNotes = allNotes.where((note) => note.isSynced).toList();
      final unsyncedNotes = allNotes.where((note) => !note.isSynced).toList();

      return {
        'total': allNotes.length,
        'synced': syncedNotes.length,
        'unsynced': unsyncedNotes.length,
        'pending_sync': unsyncedNotes.length,
        'is_syncing': false, // this would be managed by a sync service
      };
    } catch (e) {
      AppLogger.error('Failed to get sync status: $e');
      rethrow;
    }
  }

  /// clear all notes (for testing)
  Future<void> clearAllNotes() async {
    try {
      if (!_isInitialized) await init();

      await _notesBox.clear();
      AppLogger.info('All notes cleared');
    } catch (e) {
      AppLogger.error('Failed to clear notes: $e');
      rethrow;
    }
  }

  /// close repository
  Future<void> close() async {
    try {
      if (_isInitialized && _notesBox.isOpen) {
        await _notesBox.close();
        _isInitialized = false;
        AppLogger.info('Note repository closed');
      }
    } catch (e) {
      AppLogger.error('Failed to close note repository: $e');
    }
  }
}

/// note model adapter for hive
class NoteModelAdapter extends TypeAdapter<NoteModel> {
  @override
  final int typeId = HiveConstants.noteTypeId;

  @override
  NoteModel read(BinaryReader reader) {
    return NoteModel(
      id: reader.readString(),
      title: reader.readString(),
      content: reader.readString(),
      colorIndex: reader.readInt(),
      createdAt: DateTime.fromMillisecondsSinceEpoch(reader.readInt()),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(reader.readInt()),
      isSynced: reader.readBool(),
      serverId: reader.readInt(),
      isDeleted: reader.readBool(),
    );
  }

  @override
  void write(BinaryWriter writer, NoteModel obj) {
    writer.writeString(obj.id);
    writer.writeString(obj.title);
    writer.writeString(obj.content);
    writer.writeInt(obj.colorIndex);
    writer.writeInt(obj.createdAt.millisecondsSinceEpoch);
    writer.writeInt(obj.updatedAt.millisecondsSinceEpoch);
    writer.writeBool(obj.isSynced);
    writer.writeInt(obj.serverId ?? 0);
    writer.writeBool(obj.isDeleted);
  }
}
