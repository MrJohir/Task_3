import '../entities/note_entity.dart';
import '../../../../core/utils/constants/enums.dart';

/// repository interface for note operations
abstract class NoteRepository {
  /// get all notes from local storage
  /// Returns: List of note entities
  Future<List<NoteEntity>> getAllNotes();

  /// get note by id from local storage
  /// [id] - Note id to retrieve
  /// Returns: Note entity or null if not found
  Future<NoteEntity?> getNoteById(String id);

  /// create new note
  /// [note] - Note entity to create
  /// Returns: Created note entity
  Future<NoteEntity> createNote(NoteEntity note);

  /// update existing note
  /// [note] - Note entity to update
  /// Returns: Updated note entity
  Future<NoteEntity> updateNote(NoteEntity note);

  /// delete note by id
  /// [id] - Note id to delete
  /// Returns: true if successful
  Future<bool> deleteNote(String id);

  /// search notes by title or content
  /// [query] - Search query string
  /// Returns: List of matching note entities
  Future<List<NoteEntity>> searchNotes(String query);

  /// filter notes by color
  /// [color] - Note color to filter by
  /// Returns: List of note entities with specified color
  Future<List<NoteEntity>> filterNotesByColor(NoteColor color);

  /// get notes by sync status
  /// [status] - Sync status to filter by
  /// Returns: List of note entities with specified sync status
  Future<List<NoteEntity>> getNotesBySyncStatus(SyncStatus status);

  /// sync note with remote server
  /// [note] - Note entity to sync
  /// Returns: Synced note entity
  Future<NoteEntity> syncNote(NoteEntity note);

  /// sync all pending notes
  /// Returns: List of sync results (success/failure)
  Future<List<bool>> syncAllPendingNotes();

  /// get pending sync count
  /// Returns: Number of notes pending sync
  Future<int> getPendingSyncCount();

  /// mark note as syncing
  /// [id] - Note id to mark as syncing
  /// Returns: true if successful
  Future<bool> markNoteAsSyncing(String id);

  /// mark note as synced
  /// [id] - Note id to mark as synced
  /// [remoteId] - Remote id from server
  /// Returns: true if successful
  Future<bool> markNoteAsSynced(String id, String remoteId);

  /// mark note sync as failed
  /// [id] - Note id to mark sync as failed
  /// Returns: true if successful
  Future<bool> markNoteSyncFailed(String id);

  /// clear all notes
  /// Returns: true if successful
  Future<bool> clearAllNotes();

  /// get notes count
  /// Returns: Total number of notes
  Future<int> getNotesCount();

  /// check if note exists
  /// [id] - Note id to check
  /// Returns: true if note exists
  Future<bool> noteExists(String id);
}