import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_3/core/common/styles/global_text_style.dart';
import 'package:task_3/core/common/widgets/custom_app_bar.dart';
import 'package:task_3/core/common/widgets/custom_button.dart';
import 'package:task_3/core/utils/constants/app_colors.dart';
import 'package:task_3/core/utils/constants/app_texts.dart';
import 'package:task_3/core/utils/constants/sizer.dart';
import 'package:task_3/features/notes/controllers/note_controller.dart';
import 'package:task_3/features/notes/views/widgets/color_picker_widget.dart';

/// note editor screen for creating and editing notes
class NoteEditorScreen extends StatefulWidget {
  /// note id for editing existing note
  final String? noteId;

  const NoteEditorScreen({super.key, this.noteId});

  @override
  State<NoteEditorScreen> createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends State<NoteEditorScreen> {
  final NoteController _noteController = Get.find<NoteController>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late TextEditingController _titleController;
  late TextEditingController _contentController;
  late FocusNode _titleFocusNode;
  late FocusNode _contentFocusNode;

  int _selectedColorIndex = 0;
  bool _isLoading = false;
  bool _hasChanges = false;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
    _loadNoteData();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _titleFocusNode.dispose();
    _contentFocusNode.dispose();
    super.dispose();
  }

  /// initialize text controllers and focus nodes
  void _initializeControllers() {
    _titleController = TextEditingController();
    _contentController = TextEditingController();
    _titleFocusNode = FocusNode();
    _contentFocusNode = FocusNode();

    // listen for changes
    _titleController.addListener(_onTextChanged);
    _contentController.addListener(_onTextChanged);
  }

  /// load note data if editing existing note
  void _loadNoteData() {
    if (widget.noteId == null) {
      // focus on title for new note
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _titleFocusNode.requestFocus();
      });
      return;
    }

    setState(() => _isLoading = true);

    try {
      final note = _noteController.getNoteById(widget.noteId!);
      if (note != null) {
        _titleController.text = note.title;
        _contentController.text = note.content;
        _selectedColorIndex = note.colorIndex;
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load note');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  /// handle text changes
  void _onTextChanged() {
    if (!_hasChanges) {
      setState(() => _hasChanges = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !_hasChanges,
      onPopInvoked: (didPop) {
        if (!didPop && _hasChanges) {
          _handleBackPress();
        }
      },
      child: Scaffold(
        appBar: CustomAppBar(
          title: _isEditing ? AppTexts.editNote : AppTexts.createNote,
          actions: [_buildSaveButton()],
        ),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _buildEditor(),
      ),
    );
  }

  /// handle back button press with unsaved changes
  void _handleBackPress() async {
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
              await _saveNote();
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

  /// check if editing existing note
  bool get _isEditing => widget.noteId != null;

  /// build save button
  Widget _buildSaveButton() {
    return TextButton(
      onPressed: _saveNote,
      child: Text(
        AppTexts.save,
        style: AppTextStyles.labelLarge.copyWith(color: AppColors.primary),
      ),
    );
  }

  /// build editor content
  Widget _buildEditor() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(Sizer.paddingMd),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitleField(),
            SizedBox(height: Sizer.md),
            _buildContentField(),
            SizedBox(height: Sizer.lg),
            _buildColorPicker(),
            SizedBox(height: Sizer.xl),
            if (_hasChanges) _buildSaveSection(),
          ],
        ),
      ),
    );
  }

  /// build title input field
  Widget _buildTitleField() {
    return TextFormField(
      controller: _titleController,
      focusNode: _titleFocusNode,
      style: AppTextStyles.titleLarge,
      decoration: InputDecoration(
        hintText: AppTexts.titleHint,
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        contentPadding: EdgeInsets.all(Sizer.paddingMd),
      ),
      validator: _validateTitle,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) => _contentFocusNode.requestFocus(),
    );
  }

  /// build content input field
  Widget _buildContentField() {
    return TextFormField(
      controller: _contentController,
      focusNode: _contentFocusNode,
      style: AppTextStyles.bodyLarge,
      maxLines: null,
      minLines: 10,
      decoration: InputDecoration(
        hintText: AppTexts.contentHint,
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        contentPadding: EdgeInsets.all(Sizer.paddingMd),
      ),
      validator: _validateContent,
    );
  }

  /// build color picker
  Widget _buildColorPicker() {
    return ColorPickerWidget(
      selectedColorIndex: _selectedColorIndex,
      onColorSelected: (index) {
        setState(() {
          _selectedColorIndex = index;
          _hasChanges = true;
        });
      },
    );
  }

  /// build save section
  Widget _buildSaveSection() {
    return CustomButton(
      text: AppTexts.save,
      onPressed: _saveNote,
      isFullWidth: true,
      icon: const Icon(Icons.save, color: AppColors.white),
    );
  }

  /// validate title input
  String? _validateTitle(String? value) {
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

  /// validate content input
  String? _validateContent(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppTexts.contentRequired;
    }
    return null;
  }

  /// save note
  Future<void> _saveNote() async {
    if (!_formKey.currentState!.validate()) return;

    final title = _titleController.text.trim();
    final content = _contentController.text.trim();

    try {
      if (_isEditing) {
        await _noteController.updateNote(
          id: widget.noteId!,
          title: title,
          content: content,
          colorIndex: _selectedColorIndex,
        );
      } else {
        await _noteController.createNote(
          title: title,
          content: content,
          colorIndex: _selectedColorIndex,
        );
      }

      // If we reach here, the operation was successful
      Get.back();
    } catch (e) {
      // Error handling is already done in the controller via EasyLoading
      // We don't need to do anything here as the user will see the error message
    }
  }
}
