import 'package:hive_flutter/hive_flutter.dart';
import '../../../../core/utils/constants/enums.dart';
import '../../../../core/utils/logging/logger.dart';
import '../models/note_model.dart';

/// local data source for note operations using Hive database
class NoteLocalDataSource {
  static const String _boxName = 'notes';
  late Box<NoteModel> _noteBox;

  /// initialize the local data source
  /// Returns: true if successful
  Future<bool> init() async {
    try {
      // register adapter if not already registered
      if (!Hive.isAdapterRegistered(0)) {
        // Note: This will be available after code generation
        // Hive.registerAdapter(NoteModelAdapter());
      }

      _noteBox = await Hive.openBox<NoteModel>(_boxName);
      AppLogger.database('INIT', _boxName, 'Local data source initialized');
      return true;
    } catch (error, stackTrace) {
      AppLogger.error('Failed to initialize local data source', error, stackTrace);
      return false;
    }
  }

  /// get all notes from local storage
  /// Returns: List of note models
  Future<List<NoteModel>> getAllNotes() async {
    try {
      final notes = _noteBox.values.toList();
      AppLogger.database('GET ALL', _boxName, 'Retrieved ${notes.length} notes');
      return notes;
    } catch (error, stackTrace) {
      AppLogger.error('Failed to get all notes', error, stackTrace);
      return [];
    }
  }

  /// get note by id
  /// [id] - Note id to retrieve
  /// Returns: Note model or null if not found
  Future<NoteModel?> getNoteById(String id) async {
    try {
      final note = _noteBox.values.firstWhere(
        (note) => note.id == id,
        orElse: () => throw StateError('Note not found'),
      );
      AppLogger.database('GET BY ID', _boxName, 'Retrieved note: $id');
      return note;
    } catch (error, stackTrace) {
      AppLogger.error('Failed to get note by id: $id', error, stackTrace);
      return null;
    }
  }

  /// save note to local storage
  /// [note] - Note model to save
  /// Returns: Saved note model
  Future<NoteModel> saveNote(NoteModel note) async {
    try {
      // find existing note index
      final existingIndex = _noteBox.values
          .toList()
          .indexWhere((existingNote) => existingNote.id == note.id);

      if (existingIndex != -1) {
        // update existing note
        await _noteBox.putAt(existingIndex, note);
        AppLogger.database('UPDATE', _boxName, 'Updated note: ${note.id}');
      } else {
        // add new note
        await _noteBox.add(note);
        AppLogger.database('CREATE', _boxName, 'Created note: ${note.id}');
      }

      return note;
    } catch (error, stackTrace) {
      AppLogger.error('Failed to save note: ${note.id}', error, stackTrace);
      rethrow;
    }
  }

  /// delete note by id
  /// [id] - Note id to delete
  /// Returns: true if successful
  Future<bool> deleteNote(String id) async {
    try {
      final noteIndex = _noteBox.values
          .toList()
          .indexWhere((note) => note.id == id);

      if (noteIndex != -1) {
        await _noteBox.deleteAt(noteIndex);
        AppLogger.database('DELETE', _boxName, 'Deleted note: $id');
        return true;
      }

      AppLogger.warning('Note not found for deletion: $id');
      return false;
    } catch (error, stackTrace) {
      AppLogger.error('Failed to delete note: $id', error, stackTrace);
      return false;
    }
  }

  /// search notes by title or content
  /// [query] - Search query string
  /// Returns: List of matching note models
  Future<List<NoteModel>> searchNotes(String query) async {
    try {
      final lowercaseQuery = query.toLowerCase();
      final filteredNotes = _noteBox.values.where((note) {
        return note.title.toLowerCase().contains(lowercaseQuery) ||
            note.content.toLowerCase().contains(lowercaseQuery);
      }).toList();

      AppLogger.database('SEARCH', _boxName, 'Found ${filteredNotes.length} notes for: $query');
      return filteredNotes;
    } catch (error, stackTrace) {
      AppLogger.error('Failed to search notes: $query', error, stackTrace);
      return [];
    }
  }

  /// filter notes by color
  /// [colorIndex] - Color index to filter by
  /// Returns: List of note models with specified color
  Future<List<NoteModel>> filterNotesByColor(int colorIndex) async {
    try {
      final filteredNotes = _noteBox.values
          .where((note) => note.colorIndex == colorIndex)
          .toList();

      AppLogger.database('FILTER BY COLOR', _boxName, 
          'Found ${filteredNotes.length} notes with color index: $colorIndex');
      return filteredNotes;
    } catch (error, stackTrace) {
      AppLogger.error('Failed to filter notes by color: $colorIndex', error, stackTrace);
      return [];
    }
  }

  /// get notes by sync status
  /// [statusIndex] - Sync status index to filter by
  /// Returns: List of note models with specified sync status
  Future<List<NoteModel>> getNotesBySyncStatus(int statusIndex) async {
    try {
      final filteredNotes = _noteBox.values
          .where((note) => note.syncStatusIndex == statusIndex)
          .toList();

      AppLogger.database('GET BY SYNC STATUS', _boxName, 
          'Found ${filteredNotes.length} notes with sync status: $statusIndex');
      return filteredNotes;
    } catch (error, stackTrace) {
      AppLogger.error('Failed to get notes by sync status: $statusIndex', error, stackTrace);
      return [];
    }
  }

  /// update note sync status
  /// [id] - Note id to update
  /// [syncStatus] - New sync status
  /// [remoteId] - Optional remote id
  /// Returns: true if successful
  Future<bool> updateNoteSyncStatus(
    String id, 
    SyncStatus syncStatus, 
    [String? remoteId]
  ) async {
    try {
      final noteIndex = _noteBox.values
          .toList()
          .indexWhere((note) => note.id == id);

      if (noteIndex != -1) {
        final note = _noteBox.getAt(noteIndex)!;
        final updatedNote = note.copyWith(
          syncStatusIndex: syncStatus.index,
          remoteId: remoteId ?? note.remoteId,
        );
        
        await _noteBox.putAt(noteIndex, updatedNote);
        AppLogger.database('UPDATE SYNC STATUS', _boxName, 
            'Updated note $id sync status to: $syncStatus');
        return true;
      }

      AppLogger.warning('Note not found for sync status update: $id');
      return false;
    } catch (error, stackTrace) {
      AppLogger.error('Failed to update note sync status: $id', error, stackTrace);
      return false;
    }
  }

  /// get pending sync count
  /// Returns: Number of notes pending sync
  Future<int> getPendingSyncCount() async {
    try {
      final pendingNotes = _noteBox.values
          .where((note) => note.syncStatusIndex == SyncStatus.pending.index)
          .length;

      AppLogger.database('GET PENDING SYNC COUNT', _boxName, 'Pending notes: $pendingNotes');
      return pendingNotes;
    } catch (error, stackTrace) {
      AppLogger.error('Failed to get pending sync count', error, stackTrace);
      return 0;
    }
  }

  /// clear all notes
  /// Returns: true if successful
  Future<bool> clearAllNotes() async {
    try {
      await _noteBox.clear();
      AppLogger.database('CLEAR ALL', _boxName, 'Cleared all notes');
      return true;
    } catch (error, stackTrace) {
      AppLogger.error('Failed to clear all notes', error, stackTrace);
      return false;
    }
  }

  /// get notes count
  /// Returns: Total number of notes
  Future<int> getNotesCount() async {
    try {
      final count = _noteBox.length;
      AppLogger.database('GET COUNT', _boxName, 'Total notes: $count');
      return count;
    } catch (error, stackTrace) {
      AppLogger.error('Failed to get notes count', error, stackTrace);
      return 0;
    }
  }

  /// check if note exists
  /// [id] - Note id to check
  /// Returns: true if note exists
  Future<bool> noteExists(String id) async {
    try {
      final exists = _noteBox.values.any((note) => note.id == id);
      AppLogger.database('NOTE EXISTS', _boxName, 'Note $id exists: $exists');
      return exists;
    } catch (error, stackTrace) {
      AppLogger.error('Failed to check if note exists: $id', error, stackTrace);
      return false;
    }
  }

  /// close the database connection
  /// Returns: true if successful
  Future<bool> close() async {
    try {
      await _noteBox.close();
      AppLogger.database('CLOSE', _boxName, 'Closed local data source');
      return true;
    } catch (error, stackTrace) {
      AppLogger.error('Failed to close local data source', error, stackTrace);
      return false;
    }
  }
}