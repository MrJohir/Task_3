import '../../../../core/services/network_caller.dart';
import '../../../../core/utils/constants/api_constants.dart';
import '../../../../core/utils/logging/logger.dart';
import '../models/note_model.dart';

/// remote data source for note operations using JSONPlaceholder API
class NoteRemoteDataSource {
  /// create note on remote server
  /// [note] - Note model to create
  /// Returns: Note model with remote id
  Future<NoteModel> createNote(NoteModel note) async {
    try {
      AppLogger.apiRequest('POST', ApiConstants.createPost, null, note.toApiJson());
      
      final response = await NetworkCaller.postRequest(
        url: ApiConstants.createPost,
        body: note.toApiJson(),
      );

      final createdNote = note.copyWith(
        remoteId: response['id']?.toString(),
        syncStatusIndex: 1, // synced
      );

      AppLogger.sync('Note created on remote server', {
        'localId': note.id,
        'remoteId': createdNote.remoteId,
      });

      return createdNote;
    } catch (error, stackTrace) {
      AppLogger.apiError(ApiConstants.createPost, error, stackTrace);
      rethrow;
    }
  }

  /// update note on remote server
  /// [note] - Note model to update
  /// Returns: Updated note model
  Future<NoteModel> updateNote(NoteModel note) async {
    try {
      if (note.remoteId == null) {
        throw Exception('Cannot update note without remote ID');
      }

      final url = '${ApiConstants.updatePost}/${note.remoteId}';
      AppLogger.apiRequest('PUT', url, null, note.toApiJson());
      
      final response = await NetworkCaller.putRequest(
        url: url,
        body: note.toApiJson(),
      );

      final updatedNote = note.copyWith(
        remoteId: response['id']?.toString(),
        syncStatusIndex: 1, // synced
      );

      AppLogger.sync('Note updated on remote server', {
        'localId': note.id,
        'remoteId': updatedNote.remoteId,
      });

      return updatedNote;
    } catch (error, stackTrace) {
      AppLogger.apiError('${ApiConstants.updatePost}/${note.remoteId}', error, stackTrace);
      rethrow;
    }
  }

  /// delete note on remote server
  /// [remoteId] - Remote id of note to delete
  /// Returns: true if successful
  Future<bool> deleteNote(String remoteId) async {
    try {
      final url = '${ApiConstants.deletePost}/$remoteId';
      AppLogger.apiRequest('DELETE', url);
      
      await NetworkCaller.deleteRequest(url: url);

      AppLogger.sync('Note deleted on remote server', {
        'remoteId': remoteId,
      });

      return true;
    } catch (error, stackTrace) {
      AppLogger.apiError('${ApiConstants.deletePost}/$remoteId', error, stackTrace);
      return false;
    }
  }

  /// get note from remote server
  /// [remoteId] - Remote id of note to retrieve
  /// Returns: Note model or null if not found
  Future<NoteModel?> getNote(String remoteId) async {
    try {
      final url = '${ApiConstants.getPost}/$remoteId';
      AppLogger.apiRequest('GET', url);
      
      final response = await NetworkCaller.getRequest(url: url);

      final note = NoteModel.fromApiResponse(response, '');

      AppLogger.sync('Note retrieved from remote server', {
        'remoteId': remoteId,
      });

      return note;
    } catch (error, stackTrace) {
      AppLogger.apiError('${ApiConstants.getPost}/$remoteId', error, stackTrace);
      return null;
    }
  }

  /// get all notes from remote server
  /// Returns: List of note models
  Future<List<NoteModel>> getAllNotes() async {
    try {
      AppLogger.apiRequest('GET', ApiConstants.getAllPosts);
      
      final response = await NetworkCaller.getRequest(url: ApiConstants.getAllPosts);

      List<NoteModel> notes = [];
      
      // handle different response formats
      if (response['data'] is List) {
        final List<dynamic> postsList = response['data'];
        notes = postsList
            .map((json) => NoteModel.fromApiResponse(json as Map<String, dynamic>, ''))
            .toList();
      } else {
        // assume single post response from JSONPlaceholder
        notes = [NoteModel.fromApiResponse(response, '')];
      }

      AppLogger.sync('Retrieved ${notes.length} notes from remote server');

      return notes;
    } catch (error, stackTrace) {
      AppLogger.apiError(ApiConstants.getAllPosts, error, stackTrace);
      return [];
    }
  }

  /// sync note with remote server (create or update based on existence)
  /// [note] - Note model to sync
  /// Returns: Synced note model
  Future<NoteModel> syncNote(NoteModel note) async {
    try {
      if (note.hasRemoteId) {
        // update existing note
        return await updateNote(note);
      } else {
        // create new note
        return await createNote(note);
      }
    } catch (error, stackTrace) {
      AppLogger.error('Failed to sync note: ${note.id}', error, stackTrace);
      // mark note as sync failed
      final failedNote = note.copyWith(syncStatusIndex: 2); // failed
      return failedNote;
    }
  }

  /// batch sync multiple notes
  /// [notes] - List of note models to sync
  /// Returns: List of sync results
  Future<List<NoteModel>> batchSyncNotes(List<NoteModel> notes) async {
    final List<NoteModel> syncedNotes = [];

    for (final note in notes) {
      try {
        final syncedNote = await syncNote(note);
        syncedNotes.add(syncedNote);
        
        // add delay between requests to avoid rate limiting
        await Future.delayed(const Duration(milliseconds: 100));
      } catch (error, stackTrace) {
        AppLogger.error('Failed to sync note in batch: ${note.id}', error, stackTrace);
        // add failed note to results
        final failedNote = note.copyWith(syncStatusIndex: 2); // failed
        syncedNotes.add(failedNote);
      }
    }

    AppLogger.sync('Batch sync completed', {
      'total': notes.length,
      'synced': syncedNotes.where((n) => n.isSynced).length,
      'failed': syncedNotes.where((n) => n.isSyncFailed).length,
    });

    return syncedNotes;
  }

  /// test connectivity to remote server
  /// Returns: true if connection is successful
  Future<bool> testConnection() async {
    try {
      AppLogger.apiRequest('GET', ApiConstants.getAllPosts);
      
      final response = await NetworkCaller.getRequest(url: ApiConstants.getAllPosts);
      
      AppLogger.info('Remote server connection test successful');
      return response.isNotEmpty;
    } catch (error, stackTrace) {
      AppLogger.error('Remote server connection test failed', error, stackTrace);
      return false;
    }
  }
}