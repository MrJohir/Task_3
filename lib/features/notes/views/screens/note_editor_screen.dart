import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_3/core/common/styles/global_text_style.dart';
import 'package:task_3/core/common/widgets/custom_app_bar.dart';
import 'package:task_3/core/common/widgets/custom_button.dart';
import 'package:task_3/core/utils/constants/app_colors.dart';
import 'package:task_3/core/utils/constants/app_texts.dart';
import 'package:task_3/core/utils/constants/sizer.dart';
import 'package:task_3/features/notes/controllers/edit_note_controller.dart';
import 'package:task_3/features/notes/views/widgets/color_picker_widget.dart';

/// note editor screen for creating and editing notes
class NoteEditorScreen extends StatelessWidget {
  /// note id for editing existing note
  final String? noteId;

  NoteEditorScreen({super.key, this.noteId});
  final EditNoteController controller = Get.put(EditNoteController());

  @override
  Widget build(BuildContext context) {
    // Initialize with note data if editing
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.initializeWithNote(noteId);
    });
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Obx(
      () => PopScope(
        canPop: !controller.hasChanges,
        onPopInvokedWithResult: (didPop, result) {
          if (!didPop && controller.hasChanges) {
            controller.handleBackPress();
          }
        },
        child: Scaffold(
          appBar: CustomAppBar(
            title: controller.isEditing
                ? AppTexts.editNote
                : AppTexts.createNote,
            actions: [
              TextButton(
                onPressed: controller.saveNote,
                child: Text(
                  AppTexts.save,
                  style: AppTextStyles.labelLarge.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
          body: controller.isLoading
              ? const Center(child: CircularProgressIndicator())
              : _buildEditor(controller, isDark),
        ),
      ),
    );
  }

  /// build editor content
  Widget _buildEditor(EditNoteController controller, bool isDark) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(Sizer.paddingMd),
      child: Form(
        key: controller.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title field
            TextFormField(
              controller: controller.titleController,
              focusNode: controller.titleFocusNode,
              style: AppTextStyles.titleMedium.copyWith(
                color: isDark
                    ? AppColors.darkTextPrimary
                    : AppColors.textPrimary,
              ),
              decoration: InputDecoration(
                hintText: AppTexts.titleHint,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: EdgeInsets.all(Sizer.paddingMd),
              ),
              validator: controller.validateTitle,
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) =>
                  controller.contentFocusNode.requestFocus(),
            ),
            SizedBox(height: Sizer.md),
            // Content field
            TextFormField(
              controller: controller.contentController,
              focusNode: controller.contentFocusNode,
              style: AppTextStyles.bodyLarge.copyWith(
                color: isDark
                    ? AppColors.darkTextPrimary
                    : AppColors.textPrimary,
              ),
              maxLines: null,
              minLines: 10,
              decoration: InputDecoration(
                hintText: AppTexts.contentHint,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: EdgeInsets.all(Sizer.paddingMd),
              ),
              validator: controller.validateContent,
            ),
            SizedBox(height: Sizer.lg),
            // Color picker
            Obx(
              () => ColorPickerWidget(
                selectedColorIndex: controller.selectedColorIndex,
                onColorSelected: controller.setColorIndex,
              ),
            ),
            SizedBox(height: Sizer.xl),
            // Save button
            if (controller.hasChanges)
              CustomButton(
                text: AppTexts.save,
                onPressed: controller.saveNote,
                isFullWidth: true,
                icon: const Icon(Icons.save, color: AppColors.white),
              ),
          ],
        ),
      ),
    );
  }
}
