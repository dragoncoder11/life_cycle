import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_cycle/core/helper/spacing.dart';
import 'package:life_cycle/core/theme/app_colors.dart';
import 'package:life_cycle/core/theme/app_text_styles.dart';
import 'package:life_cycle/core/widgets/custom_button.dart';
import 'package:life_cycle/core/widgets/custom_text_form_field.dart';
import 'package:life_cycle/features/finance/view/widgets/pick_date_container.dart';

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
            children: [
              Expanded(
                child: SingleChildScrollView(
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
                            style: AppTextStyles.interBlack(
                              24,
                              FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      verticalSpace(10.h),
                      Image.asset(
                        'assets/images/monthly_balance.png',
                        height: 160.h,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      verticalSpace(12.h),
                      Text(
                        'Amount',
                        style: AppTextStyles.interBlack(16, FontWeight.w500),
                      ),
                      verticalSpace(4.h),
                      CustomTextFormField(
                        borderColor: AppColors.background,
                        textInputType: TextInputType.number,
                        filled: true,
                        hintText: 'Enter your Salary',
                        maxLines: 1,
                        prefixIcon: Icon(
                          Icons.paid,
                          color: AppColors.kPrimaryColor,
                        ),
                      ),
                      verticalSpace(12.h),
                      Text(
                        'Salary Period',
                        style: AppTextStyles.interBlack(18, FontWeight.w600),
                      ),
                      Text(
                        'Choose the start and end date of your salary cycle',
                        style: AppTextStyles.interGrey(15, FontWeight.w400),
                      ),
                      verticalSpace(10.h),
                      PickDateContainer(),
                    ],
                  ),
                ),
              ),
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
