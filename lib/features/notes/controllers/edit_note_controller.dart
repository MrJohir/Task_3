import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_3/core/utils/constants/app_texts.dart';
import 'package:task_3/core/utils/logging/logger.dart';
import 'package:task_3/features/notes/controllers/note_controller.dart';

/// Controller for managing note editing operations
class EditNoteController extends GetxController {
  final NoteController _noteController = Get.find<NoteController>();

  // Text controllers
  late TextEditingController titleController;
  late TextEditingController contentController;

  // Focus nodes
  late FocusNode titleFocusNode;
  late FocusNode contentFocusNode;

  // Reactive variables
  final RxInt _selectedColorIndex = 0.obs;
  final RxBool _isLoading = false.obs;
  final RxBool _hasChanges = false.obs;
  final RxString _noteId = ''.obs;

  // Form key
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Getters
  int get selectedColorIndex => _selectedColorIndex.value;
  bool get isLoading => _isLoading.value;
  bool get hasChanges => _hasChanges.value;
  bool get isEditing => _noteId.value.isNotEmpty;
  String? get noteId => _noteId.value.isEmpty ? null : _noteId.value;

  @override
  void onInit() {
    super.onInit();
    _initializeControllers();
  }

  @override
  void onClose() {
    titleController.dispose();
    contentController.dispose();
    titleFocusNode.dispose();
    contentFocusNode.dispose();
    super.onClose();
  }

  /// Initialize text controllers and focus nodes
  void _initializeControllers() {
    titleController = TextEditingController();
    contentController = TextEditingController();
    titleFocusNode = FocusNode();
    contentFocusNode = FocusNode();

    // Listen for text changes
    titleController.addListener(_onTextChanged);
    contentController.addListener(_onTextChanged);
  }

  /// Initialize with note data if editing
  void initializeWithNote(String? noteId) {
    if (noteId == null) {
      // New note - focus on title
      _noteId.value = '';
      WidgetsBinding.instance.addPostFrameCallback((_) {
        titleFocusNode.requestFocus();
      });
      return;
    }

    _noteId.value = noteId;
    _loadNoteData(noteId);
  }

  /// Load note data for editing
  void _loadNoteData(String noteId) {
    try {
      _isLoading.value = true;

      final note = _noteController.getNoteById(noteId);
      if (note != null) {
        titleController.text = note.title;
        contentController.text = note.content;
        _selectedColorIndex.value = note.colorIndex;

        // Reset change tracking after loading data
        _hasChanges.value = false;

        AppLogger.info('Loaded note data for editing: $noteId');
      } else {
        Get.snackbar('Error', 'Note not found');
        Get.back();
      }
    } catch (e) {
      AppLogger.error('Failed to load note data: $e');
      Get.snackbar('Error', 'Failed to load note');
    } finally {
      _isLoading.value = false;
    }
  }

  /// Handle text changes
  void _onTextChanged() {
    if (!_hasChanges.value) {
      _hasChanges.value = true;
    }
  }

  /// Set selected color index
  void setColorIndex(int index) {
    _selectedColorIndex.value = index;
    _hasChanges.value = true;
  }

  /// Validate title input
  String? validateTitle(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppTexts.titleRequired;
    }
    if (value.trim().length < 3) {
      return AppTexts.titleTooShort;
    }
    if (value.trim().length > 100) {
      return AppTexts.titleTooLong;
    }
    return null;
  }

  /// Validate content input
  String? validateContent(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppTexts.contentRequired;
    }
    return null;
  }

  /// Save note
  Future<void> saveNote() async {
    if (!formKey.currentState!.validate()) return;

    final title = titleController.text.trim();
    final content = contentController.text.trim();

    try {
      if (isEditing) {
        await _noteController.updateNote(
          id: _noteId.value,
          title: title,
          content: content,
          colorIndex: _selectedColorIndex.value,
        );
        AppLogger.info('Note updated successfully: ${_noteId.value}');
      } else {
        await _noteController.createNote(
          title: title,
          content: content,
          colorIndex: _selectedColorIndex.value,
        );
        AppLogger.info('Note created successfully');
      }

      // Reset change tracking
      _hasChanges.value = false;

      // Navigate back
      Get.back();
    } catch (e) {
      AppLogger.error('Failed to save note: $e');
      // Error handling is already done in the NoteController via EasyLoading
    }
  }

  /// Handle back button press with unsaved changes
  Future<void> handleBackPress() async {
    if (!_hasChanges.value) {
      Get.back();
      return;
    }

    final result = await Get.dialog<bool>(
      AlertDialog(
        title: const Text(AppTexts.unsavedChangesTitle),
        content: const Text(AppTexts.unsavedChangesMessage),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text(AppTexts.cancel),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            child: const Text(AppTexts.no),
          ),
          TextButton(
            onPressed: () async {
              Get.back(result: false);
              await saveNote();
            },
            child: const Text(AppTexts.yes),
          ),
        ],
      ),
    );

    if (result == true) {
      Get.back();
    }
  }

  /// Reset controller state
  void resetState() {
    titleController.clear();
    contentController.clear();
    _selectedColorIndex.value = 0;
    _isLoading.value = false;
    _hasChanges.value = false;
    _noteId.value = '';
  }
}
