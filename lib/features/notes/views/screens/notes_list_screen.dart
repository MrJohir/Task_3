import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_3/core/common/widgets/custom_app_bar.dart';
import 'package:task_3/core/common/widgets/empty_state_widget.dart';
import 'package:task_3/core/utils/constants/app_colors.dart';
import 'package:task_3/core/utils/constants/app_texts.dart';
import 'package:task_3/core/utils/constants/sizer.dart';
import 'package:task_3/core/widgets/shimmer_widgets.dart';
import 'package:task_3/features/notes/controllers/note_controller.dart';
import 'package:task_3/features/notes/views/screens/note_editor_screen.dart';
import 'package:task_3/features/notes/views/widgets/note_card_widget.dart';
import 'package:task_3/features/notes/views/widgets/search_widget.dart';
import 'package:task_3/features/settings/views/screens/settings_screen.dart';

/// notes list screen - main screen showing all notes
class NotesListScreen extends StatefulWidget {
  const NotesListScreen({super.key});

  @override
  State<NotesListScreen> createState() => _NotesListScreenState();
}

class _NotesListScreenState extends State<NotesListScreen> {
  final NoteController _noteController = Get.find<NoteController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        centerTitle: true,
        title: AppTexts.notes,
        showBackButton: false,
        actions: [_buildSyncButton(), _buildSettingsButton()],
      ),
      body: Column(
        children: [
          _buildSearchSection(),
          Expanded(child: _buildNotesSection()),
        ],
      ),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  /// build search section
  Widget _buildSearchSection() {
    return SearchWidget(
      onSearchChanged: _noteController.searchNotes,
      initialQuery: _noteController.searchQuery,
    );
  }

  /// build notes section
  Widget _buildNotesSection() {
    return Obx(() {
      if (_noteController.isLoading) {
        return const NotesListShimmer();
      }

      if (_noteController.isEmpty) {
        return EmptyStateWidget(
          type: _noteController.isSearching
              ? EmptyStateType.noSearchResults
              : EmptyStateType.noNotes,
          onActionPressed: _noteController.isSearching
              ? _noteController.clearSearch
              : _navigateToCreateNote,
        );
      }

      return RefreshIndicator(
        onRefresh: _noteController.refreshNotes,
        child: _buildNotesList(),
      );
    });
  }

  /// build notes list
  Widget _buildNotesList() {
    return ListView.builder(
      padding: EdgeInsets.only(
        bottom: Sizer.paddingXl * 2, // space for FAB
      ),
      itemCount: _noteController.notes.length,
      itemBuilder: (context, index) {
        final note = _noteController.notes[index];
        return NoteCardWidget(
          note: note,
          onTap: () => _navigateToEditNote(note.id),
          onDelete: () => _showDeleteNoteDialog(note.id, note.title),
        );
      },
    );
  }

  /// build sync button
  Widget _buildSyncButton() {
    return Obx(() {
      final hasUnsyncedNotes = _noteController.hasUnsyncedNotes;

      return IconButton(
        onPressed: _noteController.syncNotes,
        icon: Icon(
          hasUnsyncedNotes ? Icons.sync_problem : Icons.sync,
          color: hasUnsyncedNotes ? AppColors.warning : null,
        ),
        tooltip: hasUnsyncedNotes
            ? 'Sync ${_noteController.unsyncedNotesCount} unsynced notes'
            : 'Sync notes',
      );
    });
  }

  /// build settings button
  Widget _buildSettingsButton() {
    return IconButton(
      onPressed: _navigateToSettings,
      icon: const Icon(Icons.settings),
      tooltip: AppTexts.settings,
    );
  }

  /// build floating action button
  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: _navigateToCreateNote,
      child: const Icon(Icons.add),
      tooltip: AppTexts.createNote,
    );
  }

  /// navigate to create note screen
  void _navigateToCreateNote() {
    Get.to(() => const NoteEditorScreen());
  }

  /// navigate to edit note screen
  void _navigateToEditNote(String noteId) {
    Get.to(() => NoteEditorScreen(noteId: noteId));
  }

  /// navigate to settings screen
  void _navigateToSettings() {
    Get.to(() => const SettingsScreen());
  }

  /// show delete note confirmation dialog
  void _showDeleteNoteDialog(String noteId, String noteTitle) {
    Get.dialog(
      AlertDialog(
        title: const Text(AppTexts.deleteNoteTitle),
        content: Text(
          '${AppTexts.deleteNoteMessage}\n\n"${noteTitle.isNotEmpty ? noteTitle : 'Untitled'}"',
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text(AppTexts.cancel),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              _noteController.deleteNote(noteId);
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text(AppTexts.delete),
          ),
        ],
      ),
    );
  }
}
