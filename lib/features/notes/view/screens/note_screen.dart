import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_cycle/core/helper/spacing.dart';
import 'package:life_cycle/core/theme/app_colors.dart';
import 'package:life_cycle/core/theme/app_text_styles.dart';
import 'package:life_cycle/core/widgets/custom_text_form_field.dart';
import 'package:life_cycle/features/notes/view/widgets/add_note_sheet.dart';
import 'package:life_cycle/features/notes/view/widgets/note_item.dart';
import 'package:life_cycle/features/notes/view/widgets/notes_list.dart';

class NoteScreen extends StatelessWidget {
  const NoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          verticalSpace(12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Notes',
                style: AppTextStyles.interBlack(24, FontWeight.bold),
              ),
              AddNoteSheet(),
            ],
          ),
          verticalSpace(10.h),
          CustomTextFormField(
            filled: true,
            borderColor: AppColors.background,
            prefixIcon: Icon(Icons.search, color: AppColors.textHint),
            hintText: 'Search notes...',
          ),
          Expanded(
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: notes.length,
              itemBuilder: (context, index) {
                return NoteItem(noteModel: notes[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
