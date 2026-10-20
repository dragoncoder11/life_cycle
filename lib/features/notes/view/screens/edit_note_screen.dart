import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_cycle/core/helper/spacing.dart';
import 'package:life_cycle/core/theme/app_colors.dart';
import 'package:life_cycle/core/theme/app_text_styles.dart';
import 'package:life_cycle/core/widgets/custom_button.dart';
import 'package:life_cycle/core/widgets/custom_circle_avatar.dart';
import 'package:life_cycle/core/widgets/custom_text_form_field.dart';

class EditNoteScreen extends StatelessWidget {
  const EditNoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 16.0.w, right: 16.0.w,bottom: 16.0.h,top: 16.0.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                 IconButton(
                    icon: Icon(Icons.arrow_back_ios, color: AppColors.textPrimary),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  CustomCircleAvatar(
                    icon: Icons.check,
                    onPressed: () {
                     
                    },
                  ),
                ],
              ),
              verticalSpace(10.h),
               Text(
                    'Edit Note',
                    style: AppTextStyles.interBlack(24, FontWeight.bold),
                  ),
                            verticalSpace(10.h),
                
               Text(
                    'Edit Note',
                    style: AppTextStyles.interBlack(
                      16,
                      FontWeight.w500,
                    ),
                  ),
                  verticalSpace(4.h),
              CustomTextFormField(hintText: 'Edit Note', maxLines: 1),
                        verticalSpace(8.h),
                         Text(
                    'Edit Description',
                    style: AppTextStyles.interBlack(
                      16,
                      FontWeight.w500,
                    ),
                  ),
                  verticalSpace(4.h),
              CustomTextFormField(hintText: 'Edit Description',maxLines: 5,),
                Spacer(),
              CustomButton(onTap: () {
                  Navigator.pop(context);
                }, title: 'Edit Note'),
            ],
          ),
        ),
      ),
    );
  }
}
