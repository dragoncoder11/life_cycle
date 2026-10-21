import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_cycle/core/helper/spacing.dart';
import 'package:life_cycle/core/theme/app_colors.dart';
import 'package:life_cycle/core/theme/app_text_styles.dart';
import 'package:life_cycle/core/widgets/custom_button.dart';
import 'package:life_cycle/core/widgets/custom_text_form_field.dart';

class AddBalanceScreen extends StatelessWidget {
  const AddBalanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
              Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: AppColors.textPrimary,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  horizontalSpace(6),
                  Text(
                    'Monthly Salary',
                    style: AppTextStyles.interBlack(24, FontWeight.bold),
                  ),
                ],
              ),
              verticalSpace(10.h),
              

              Text(
                'Amount',
                style: AppTextStyles.interBlack(16, FontWeight.w500),
              ),
              verticalSpace(4.h),
              CustomTextFormField(hintText: 'Enter your Salary', maxLines: 1,prefixIcon: Icon(Icons.paid),),
              verticalSpace(12.h),
              Text(
                'Start Date',
                style: AppTextStyles.interBlack(16, FontWeight.w500),
              ),
              verticalSpace(4.h),
              CustomTextFormField(
                prefixIcon: Icon(Icons.date_range),
                hintText: 'Start Date',
              ),
              verticalSpace(12.h),
              Text(
                'End Date',
                style: AppTextStyles.interBlack(16, FontWeight.w500),
              ),
              verticalSpace(4.h),
              CustomTextFormField(
                prefixIcon: Icon(Icons.lock_clock),
                hintText: 'End Date',
              ),
              Spacer(),
              CustomButton(
                onTap: () {
                  Navigator.pop(context);
                },
                title: 'Save',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
