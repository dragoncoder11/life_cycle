
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_cycle/core/helper/spacing.dart';
import 'package:life_cycle/core/theme/app_colors.dart';
import 'package:life_cycle/core/theme/app_text_styles.dart';
import 'package:life_cycle/core/widgets/custom_button.dart';
import 'package:life_cycle/core/widgets/custom_text_form_field.dart';

class ShowNoteModelButtonSheetBody extends StatelessWidget {
  const ShowNoteModelButtonSheetBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add Note',
                style: AppTextStyles.interWhite(
                  16,
                  FontWeight.w500,
                ),
              ),
              verticalSpace(4.h),
          
              CustomTextFormField(hintText: 'Add Note'),
              verticalSpace(16.h),
              Text(
                'Add Description',
                style: AppTextStyles.interWhite(
                  16,
                  FontWeight.w500,
                ),
              ),
              verticalSpace(4.h),
          
              CustomTextFormField(hintText: 'Add Description',maxLines: 5,),
              verticalSpace(40.h),
              CustomButton(onTap: () {
                Navigator.pop(context);
              }, title: 'Add Note'),
            ],
          ),
        ),
      ),
    );
  }
}
