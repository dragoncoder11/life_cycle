import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_cycle/core/theme/app_colors.dart';
import 'package:life_cycle/core/theme/app_text_styles.dart';
import 'package:life_cycle/core/widgets/custom_button.dart';
import 'package:life_cycle/core/widgets/custom_text_form_field.dart';
import 'package:life_cycle/features/finance/logic/cubit/finance_cubit.dart';

Future<void> showInitialBalanceDialog(
  BuildContext context,
  FinanceCubit cubit,
) async {
  final controller = TextEditingController();

  try {
    await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: AppColors.whiteColor,
          scrollable: true,
          insetPadding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 24.h,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            'Set Initial Balance',
            style: AppTextStyles.interBlack(
              20,
              FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Enter your current balance to start tracking your finances.',
                style: AppTextStyles.interGrey(
                  14,
                  FontWeight.w400,
                ),
              ),

              SizedBox(height: 20.h),

              Text(
                'Amount',
                style: AppTextStyles.interBlack(
                  15,
                  FontWeight.w500,
                ),
              ),

              SizedBox(height: 8.h),

              CustomTextFormField(
                controller: controller,
                hintText: 'Enter your initial balance',
                textInputType:
                    const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                filled: true,
                filledColor: Colors.white,
                borderColor: AppColors.whiteColor,
                prefixIcon: Icon(
                  Icons.account_balance_wallet_outlined,
                  color: AppColors.kPrimaryColor,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: Text(
                'Skip',
                style: AppTextStyles.interGrey(
                  14,
                  FontWeight.w500,
                ),
              ),
            ),

            SizedBox(
              width: 100.w,
              child: CustomButton(
                size: 14,
                title: 'Save',
                onTap: () async {
                  final amount = double.tryParse(
                    controller.text.trim(),
                  );

                  if (amount == null || amount < 0) {
                    ScaffoldMessenger.of(dialogContext).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Please enter a valid amount',
                        ),
                      ),
                    );
                    return;
                  }

                  await cubit.setInitialBalance(amount);

                  if (dialogContext.mounted) {
                    Navigator.pop(dialogContext);
                  }
                },
              ),
            ),
          ],
        );
      },
    );
  } finally {
    controller.dispose();
  }
}