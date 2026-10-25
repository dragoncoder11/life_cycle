import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_cycle/core/helper/spacing.dart';
import 'package:life_cycle/core/theme/app_colors.dart';
import 'package:life_cycle/core/theme/app_text_styles.dart';
import 'package:life_cycle/core/widgets/custom_circle_avatar.dart';
import 'package:life_cycle/core/widgets/custom_text_form_field.dart';
import 'package:life_cycle/features/notes/data/models/note_model.dart';
import 'package:life_cycle/features/notes/view/widgets/note_item.dart';
import 'package:life_cycle/features/notes/view/widgets/show_model_button_sheet_body.dart';

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
              CustomCircleAvatar(
                icon: Icons.add,
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    useSafeArea: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                    ),
                    builder: (context) {
                      return AnimatedPadding(
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeOut,
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.viewInsetsOf(context).bottom,
                        ),
                        child: ShowNoteModelButtonSheetBody(),
                      );
                    },
                  );
                },
              ),
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
