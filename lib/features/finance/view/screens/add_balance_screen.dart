import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:life_cycle/core/helper/spacing.dart';
import 'package:life_cycle/core/theme/app_colors.dart';
import 'package:life_cycle/core/theme/app_text_styles.dart';
import 'package:life_cycle/core/theme/status_bar_mode.dart';
import 'package:life_cycle/core/widgets/custom_button.dart';
import 'package:life_cycle/core/widgets/custom_text_form_field.dart';
import 'package:life_cycle/features/finance/logic/cubit/finance_cubit.dart';

class AddBalanceScreen extends StatelessWidget {
  const AddBalanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FinanceCubit>();

    return StatusBarMode(
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16.w),
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
                                color: AppColors.darkGreenColor,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            horizontalSpace(6),
                            Text(
                              'Initial Balance',
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
                          style: AppTextStyles.interBlack(
                            16,
                            FontWeight.w500,
                          ),
                        ),
      
                        verticalSpace(4.h),
      
                        CustomTextFormField(
                          controller: cubit.initialBalanceController,
                          borderColor: AppColors.whiteColor,
                          textInputType:
                              const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          filled: true,
                          hintText: 'Enter your initial balance',
                          maxLines: 1,
                          prefixIcon: Icon(
                            Icons.paid,
                            color: AppColors.kPrimaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
      
                CustomButton(
                  onTap: () async {
                    final amount = double.tryParse(
                      cubit.initialBalanceController.text.trim(),
                    );
      
                    if (amount == null || amount < 0) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please enter a valid amount'),
                        ),
                      );
                      return;
                    }
      
                    await cubit.setInitialBalance(amount);
      
                    if (context.mounted) {
                      Navigator.pop(context);
                    }
                  },
                  title: 'Save',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
