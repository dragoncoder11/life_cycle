import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_cycle/core/helper/spacing.dart';
import 'package:life_cycle/core/theme/app_colors.dart';
import 'package:life_cycle/core/theme/app_text_styles.dart';
import 'package:life_cycle/core/widgets/custom_button.dart';
import 'package:life_cycle/core/widgets/custom_text_form_field.dart';
import 'package:life_cycle/features/notes/data/models/note_model.dart';
import 'package:life_cycle/features/notes/logic/get_notes/notes_cubit.dart';

class EditNoteScreen extends StatelessWidget {
  const EditNoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<NotesCubit>(context);
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final noteModel = args['note'] as NoteModel;
    cubit.title = TextEditingController(text: noteModel.title);
    cubit.describtion = TextEditingController(text: noteModel.content);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: 16.0.w,
            right: 16.0.w,
            bottom: 16.0.h,
            top: 16.0.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back_ios, color: AppColors.textPrimary),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              verticalSpace(10.h),
              Text(
                'Edit Note',
                style: AppTextStyles.interBlack(24, FontWeight.bold),
              ),
              verticalSpace(10.h),

              Text(
                'Edit Note',
                style: AppTextStyles.interBlack(16, FontWeight.w500),
              ),
              verticalSpace(4.h),
              CustomTextFormField(
                // onChanged: (newTitle) {
                //   cubit.title!.text = newTitle;
                // },
                controller: cubit.title,
                maxLines: 1,
                filled: true,
              ),
              verticalSpace(8.h),
              Text(
                'Edit Description',
                style: AppTextStyles.interBlack(16, FontWeight.w500),
              ),
              verticalSpace(4.h),
              CustomTextFormField(
                filled: true,
                // onChanged: (newDescribtion) {
                //   cubit.describtion!.text = newDescribtion;
                // },
                controller: cubit.describtion,
                maxLines: 5,
              ),
              Spacer(),
              CustomButton(
                onTap: () async {
                  noteModel.title = cubit.title!.text.trim().isEmpty
                      ? noteModel.title
                      : cubit.title!.text.trim();

                  noteModel.content = cubit.describtion!.text.trim().isEmpty
                      ? noteModel.content
                      : cubit.describtion!.text.trim();

                  await noteModel.save();

                  cubit.fetchNotes();

                  Navigator.pop(context);
                },
                title: 'Edit Note',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
