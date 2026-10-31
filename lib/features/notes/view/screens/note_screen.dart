import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_cycle/core/helper/spacing.dart';
import 'package:life_cycle/core/theme/app_colors.dart';
import 'package:life_cycle/core/theme/app_text_styles.dart';
import 'package:life_cycle/core/widgets/custom_text_form_field.dart';
import 'package:life_cycle/features/notes/logic/get_notes/notes_cubit.dart';
import 'package:life_cycle/features/notes/view/widgets/add_note_sheet.dart';
import 'package:life_cycle/features/notes/view/widgets/notes_list_view.dart';

class NoteScreen extends StatelessWidget {
  const NoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          verticalSpace(12.h),

          // Header
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: BlocBuilder<NotesCubit, NotesState>(
              builder: (context, state) {
                var cubit = context.read<NotesCubit>();

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      cubit.isSelectionMode
                          ? '${cubit.selectedNotes.length} Selected'
                          : 'Notes',
                      style: AppTextStyles.interBlack(
                        24,
                        FontWeight.bold,
                      ),
                    ),

                    if (cubit.isSelectionMode) ...[
                      IconButton(
                        onPressed: () async {
                          await cubit.deleteSelectedNotes();
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),

                      IconButton(
                        onPressed: () {
                          cubit.clearSelection();
                        },
                        icon: const Icon(
                          Icons.close,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ] else
                      const AddNoteSheet(),
                  ],
                );
              },
            ),
          ),

          verticalSpace(10.h),

          // Search
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: CustomTextFormField(
              filled: true,
              borderColor: AppColors.background,
              prefixIcon: Icon(
                Icons.search,
                color: AppColors.textHint,
              ),
              hintText: 'Search notes...',
            ),
          ),

          Expanded(
            child: NotesListView(),
          ),
        ],
      ),
    );
  }
}