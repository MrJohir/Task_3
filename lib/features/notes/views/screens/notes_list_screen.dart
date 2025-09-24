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
class NotesListScreen extends StatelessWidget {
  NotesListScreen({super.key});

  final NoteController _noteController = Get.put(NoteController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppTexts.notes,
        showBackButton: false,
        actions: [
          Obx(() {
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
          }),
          IconButton(
            onPressed: () => Get.to(() => SettingsScreen()),
            icon: const Icon(Icons.settings),
            tooltip: AppTexts.settings,
          ),
        ],
      ),
      body: Column(
        children: [
          const SearchWidget(),
          Expanded(child: _buildNotesSection()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() =>  NoteEditorScreen()),
        tooltip: AppTexts.createNote,
        child: const Icon(Icons.add),
      ),
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
              : () => Get.to(() =>  NoteEditorScreen()),
        );
      }

      return RefreshIndicator(
        onRefresh: _noteController.refreshNotes,
        child: ListView.builder(
          padding: EdgeInsets.only(
            bottom: Sizer.paddingXl * 2, // space for FAB
          ),
          itemCount: _noteController.notes.length,
          itemBuilder: (context, index) {
            final note = _noteController.notes[index];
            return NoteCardWidget(
              note: note,
              onTap: () => Get.to(() => NoteEditorScreen(noteId: note.id)),
              onDelete: () => _showDeleteNoteDialog(note.id, note.title),
            );
          },
        ),
      );
    });
  }

  /// show delete note confirmation dialog
  void _showDeleteNoteDialog(String noteId, String noteTitle) {
    Get.dialog(
      AlertDialog(
        title: const Text(AppTexts.deleteNoteTitle),
        content: Text(
          '${AppTexts.deleteNoteMessage}\n\n${noteTitle.isNotEmpty ? noteTitle : 'Untitled'}',
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
