import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_cycle/core/helper/spacing.dart';
import 'package:life_cycle/core/theme/app_colors.dart';
import 'package:life_cycle/core/theme/app_text_styles.dart';
import 'package:life_cycle/core/widgets/custom_button.dart';
import 'package:life_cycle/core/widgets/custom_text_form_field.dart';
import 'package:life_cycle/features/notes/data/models/note_model.dart';
import 'package:life_cycle/features/notes/logic/add_note_cubit/add_note_cubit.dart';

class ShowNoteModelButtonSheetBody extends StatelessWidget {
  const ShowNoteModelButtonSheetBody({super.key});
  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<AddNoteCubit>(context);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        color: AppColors.textPrimary,
      ),
      child: Padding(
        padding: EdgeInsets.only(
          top: 32.h,
          bottom: 16.w,
          left: 16.w,
          right: 16.w,
        ),
        child: BlocConsumer<AddNoteCubit, AddNoteState>(
          listener: (context, state) {
            if (state is AddNoteSuccess) {
              Navigator.pop(context);
            }
            if (state is AddNoteFailure) {
              SnackBar(content: Text(state.errMessage.toString()));
            }
          },
          builder: (context, state) {
            return Form(
              key: cubit.formKey,
              autovalidateMode: cubit.autovalidateMode,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Add Note',
                      style: AppTextStyles.interWhite(16, FontWeight.w500),
                    ),
                    verticalSpace(4.h),

                    CustomTextFormField(
                      hintText: 'Add Note',
                      controller: cubit.titleController,
                      validate: (value) {
                        if (value == null || value.trim() == '') {
                          return 'field is required';
                        } else {
                          return null;
                        }
                      },
                    ),
                    verticalSpace(16.h),
                    Text(
                      'Add Description',
                      style: AppTextStyles.interWhite(16, FontWeight.w500),
                    ),
                    verticalSpace(4.h),

                    CustomTextFormField(
                      hintText: 'Add Description',
                      maxLines: 5,
                      controller: cubit.contentController,
                      validate: (value) {
                        if (value == null || value.trim() == '') {
                          return 'field is required';
                        } else {
                          return null;
                        }
                      },
                    ),
                    verticalSpace(40.h),
                    CustomButton(
                      onTap: () async {
                        if (cubit.formKey.currentState!.validate()) {
                          cubit.formKey.currentState!.save();
                          var noteModel = NoteModel(
                            title: cubit.titleController.text.trim(),
                            content: cubit.contentController.text.trim(),
                            createdAt: DateTime.now(),
                          );
                          await cubit.addNote(noteModel);
                        } else {
                          cubit.changeAutoValidateMode();
                        }
                      },
                      // title: 'Add Note',
                      onCenter: Center(
                        child: state is AddNoteLoading
                            ? CircularProgressIndicator()
                            : Text(
                                'Add Note',
                                style: AppTextStyles.interWhite(
                                  24,
                                  FontWeight.w600,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
