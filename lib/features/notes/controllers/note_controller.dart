import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:task_3/core/services/connectivity_service.dart';
import 'package:task_3/core/utils/constants/app_texts.dart';
import 'package:task_3/core/utils/logging/logger.dart';
import 'package:task_3/features/notes/models/note_model.dart';
import 'package:task_3/core/services/note_repository.dart';

/// note controller for managing note operations
class NoteController extends GetxController {
  final NoteRepository _noteRepository = Get.put(NoteRepository());
  final ConnectivityService _connectivityService = Get.put(
    ConnectivityService(),
  );

  // search related controllers
  late final TextEditingController searchController;
  late final FocusNode searchFocusNode;

  // reactive variables
  final RxList<NoteModel> _notes = <NoteModel>[].obs;
  final RxList<NoteModel> _filteredNotes = <NoteModel>[].obs;
  final RxBool _isLoading = false.obs;
  final RxBool _isSyncing = false.obs;
  final RxString _searchQuery = ''.obs;
  final RxBool _isSearching = false.obs;

  // getters
  List<NoteModel> get notes => _filteredNotes;
  bool get isLoading => _isLoading.value;
  bool get isSyncing => _isSyncing.value;
  bool get isEmpty => _filteredNotes.isEmpty;
  String get searchQuery => _searchQuery.value;
  bool get isSearching => _isSearching.value;

  @override
  void onInit() {
    super.onInit();
    searchController = TextEditingController();
    searchFocusNode = FocusNode();
    _initializeRepository();
  }

  @override
  void onClose() {
    searchController.dispose();
    searchFocusNode.dispose();
    super.onClose();
  }

  /// initialize repository and load notes
  Future<void> _initializeRepository() async {
    try {
      await _noteRepository.init();
      await loadNotes();
      AppLogger.info('Note controller initialized successfully');
    } catch (e) {
      AppLogger.error('Failed to initialize note controller: $e');
      EasyLoading.showError('Failed to initialize notes');
    }
  }

  /// load notes from repository with shimmer effect
  Future<void> loadNotes() async {
    try {
      _isLoading.value = true;

      // Add minimum loading time to show shimmer effect
      final loadingFuture = _noteRepository.getAllNotes();
      final minimumDelay = Future.delayed(const Duration(milliseconds: 800));

      final results = await Future.wait([loadingFuture, minimumDelay]);
      final notes = results[0] as List<NoteModel>;

      _notes.value = notes;
      _applySearchFilter();

      AppLogger.info('Loaded ${notes.length} notes');
    } catch (e) {
      AppLogger.error('Failed to load notes: $e');
      EasyLoading.showError('Failed to load notes');
    } finally {
      _isLoading.value = false;
    }
  }

  /// search notes with shimmer effect for filtering
  Future<void> searchNotes(String query) async {
    try {
      _searchQuery.value = query;
      _isSearching.value = query.isNotEmpty;

      if (query.isNotEmpty) {
        // Show shimmer effect for search
        _isLoading.value = true;
        await Future.delayed(const Duration(milliseconds: 300));
      }

      _applySearchFilter();
    } catch (e) {
      AppLogger.error('Failed to search notes: $e');
    } finally {
      if (query.isNotEmpty) {
        _isLoading.value = false;
      }
    }
  }

  /// clear search
  void clearSearch() {
    searchController.clear();
    searchFocusNode.unfocus();
    _searchQuery.value = '';
    _isSearching.value = false;
    _filteredNotes.value = _notes;
  }

  /// apply search filter to current notes
  void _applySearchFilter() {
    if (_searchQuery.value.isEmpty) {
      _filteredNotes.value = _notes;
    } else {
      final query = _searchQuery.value.toLowerCase();
      _filteredNotes.value = _notes
          .where(
            (note) =>
                note.title.toLowerCase().contains(query) ||
                note.content.toLowerCase().contains(query),
          )
          .toList();
    }
  }

  /// create new note
  Future<void> createNote({
    required String title,
    required String content,
    int colorIndex = 0,
  }) async {
    try {
      EasyLoading.show(status: 'Saving...');

      final note = NoteModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: title,
        content: content,
        colorIndex: colorIndex,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        isSynced: false,
      );

      await _noteRepository.createNote(note);
      await loadNotes();

      EasyLoading.showSuccess(AppTexts.noteCreated);
      AppLogger.info('Note created successfully: ${note.id}');
    } catch (e) {
      AppLogger.error('Failed to create note: $e');
      EasyLoading.showError('Failed to save note');
    }
  }

  /// update existing note
  Future<void> updateNote({
    required String id,
    required String title,
    required String content,
    int? colorIndex,
  }) async {
    try {
      EasyLoading.show(status: 'Saving...');

      final existingNote = _notes.firstWhere((note) => note.id == id);
      final updatedNote = existingNote.copyWith(
        title: title,
        content: content,
        colorIndex: colorIndex ?? existingNote.colorIndex,
        updatedAt: DateTime.now(),
        isSynced: false, // mark as unsynced after update
      );

      await _noteRepository.updateNote(updatedNote);
      await loadNotes();

      EasyLoading.showSuccess(AppTexts.noteUpdated);
      AppLogger.info('Note updated successfully: $id');
    } catch (e) {
      AppLogger.error('Failed to update note: $e');
      EasyLoading.showError('Failed to update note');
    }
  }

  /// delete note
  Future<void> deleteNote(String id) async {
    try {
      EasyLoading.show(status: 'Deleting...');

      await _noteRepository.deleteNote(id);
      await loadNotes();

      EasyLoading.showSuccess(AppTexts.noteDeleted);
      AppLogger.info('Note deleted successfully: $id');
    } catch (e) {
      AppLogger.error('Failed to delete note: $e');
      EasyLoading.showError('Failed to delete note');
    }
  }

  /// get note by id
  NoteModel? getNoteById(String id) {
    try {
      return _notes.firstWhere((note) => note.id == id);
    } catch (e) {
      AppLogger.warning('Note not found: $id');
      return null;
    }
  }

  /// sync all unsynced notes with server
  Future<void> syncNotes() async {
    if (_isSyncing.value) return;

    try {
      _isSyncing.value = true;
      EasyLoading.show(status: 'Syncing notes...');

      if (!_connectivityService.isConnected) {
        EasyLoading.showInfo('No internet connection');
        return;
      }

      final unsyncedNotes = _notes.where((note) => !note.isSynced).toList();

      if (unsyncedNotes.isEmpty) {
        EasyLoading.showInfo('All notes are synced');
        return;
      }

      // Use repository's sync method
      await _noteRepository.syncPendingNotes();
      await loadNotes();

      EasyLoading.showSuccess('All notes synced successfully');
      AppLogger.info('Synced ${unsyncedNotes.length} notes');
    } catch (e) {
      AppLogger.error('Failed to sync notes: $e');
      EasyLoading.showError('Failed to sync notes');
    } finally {
      _isSyncing.value = false;
    }
  }

  /// get controller statistics
  Map<String, dynamic> getStatistics() {
    final totalNotes = _notes.length;
    final syncedNotes = _notes.where((note) => note.isSynced).length;
    final unsyncedNotes = totalNotes - syncedNotes;

    return {
      'total_notes': totalNotes,
      'synced_notes': syncedNotes,
      'unsynced_notes': unsyncedNotes,
      'is_connected': _connectivityService.isConnected,
      'is_loading': _isLoading.value,
      'is_syncing': _isSyncing.value,
      'search_query': _searchQuery.value,
      'is_searching': _isSearching.value,
    };
  }

  /// get sync status for dashboard
  Map<String, dynamic> getSyncStatus() {
    if (_isSyncing.value) {
      return {
        'status': 'syncing',
        'message': 'Syncing notes...',
        'pending_sync': unsyncedNotesCount,
        'is_syncing': true,
      };
    }

    if (!_connectivityService.isConnected) {
      return {
        'status': 'offline',
        'message': 'No internet connection',
        'pending_sync': unsyncedNotesCount,
        'is_syncing': false,
      };
    }

    if (hasUnsyncedNotes) {
      return {
        'status': 'pending',
        'message': '$unsyncedNotesCount notes pending sync',
        'pending_sync': unsyncedNotesCount,
        'is_syncing': false,
      };
    }

    return {
      'status': 'synced',
      'message': 'All notes synced',
      'pending_sync': 0,
      'is_syncing': false,
    };
  }

  /// refresh notes with shimmer effect
  Future<void> refreshNotes() async {
    await loadNotes();
  }

  /// get notes count
  int get notesCount => _notes.length;

  /// get unsynced notes count
  int get unsyncedNotesCount => _notes.where((note) => !note.isSynced).length;

  /// check if has unsynced notes
  bool get hasUnsyncedNotes => unsyncedNotesCount > 0;
}
