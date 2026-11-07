import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:life_cycle/core/helper/spacing.dart';
import 'package:life_cycle/core/theme/app_colors.dart';
import 'package:life_cycle/core/theme/app_text_styles.dart';
import 'package:life_cycle/features/finance/logic/cubit/finance_cubit.dart';
import 'package:life_cycle/features/finance/logic/cubit/finance_state.dart';

class MonthlySummary extends StatelessWidget {
  const MonthlySummary({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocBuilder<FinanceCubit, FinanceState>(
      builder: (context, state) {
        final cubit = context.read<FinanceCubit>();

        final rate = cubit.spendingRate;
        final progress = rate == null ? 0.0 : (rate / 100).clamp(0.0, 1.0);

        return Container(
          width: double.infinity,
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: isDark ? AppColors.notificationCard : AppColors.whiteColor,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: isDark
                    ? AppColors.whiteColor.withOpacity(.08)
                    : AppColors.blackColor.withOpacity(.08),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Monthly Summary',
                style: Theme.of(
                  context,
                ).textTheme.displaySmall?.copyWith(fontSize: 16.sp),
              ),

              verticalSpace(4.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Net Savings',
                    style: AppTextStyles.interGrey(13, FontWeight.w500),
                  ),
                  Text(
                    '${cubit.netSavings.toStringAsFixed(0)} EGP',
                    style: AppTextStyles.interBlack(15, FontWeight.bold)
                        .copyWith(
                          color: cubit.netSavings >= 0
                              ? AppColors.kPrimaryColor
                              : AppColors.redColor,
                        ),
                  ),
                ],
              ),

              verticalSpace(4.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Spending Rate',
                    style: AppTextStyles.interGrey(13, FontWeight.w500),
                  ),
                  Text(
                    rate == null ? 'N/A' : '${rate.toStringAsFixed(1)}%',
                    style: Theme.of(
                      context,
                    ).textTheme.displayMedium?.copyWith(fontSize: 15.sp),
                  ),
                ],
              ),

              verticalSpace(4.h),

              ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 8.h,
                  backgroundColor: AppColors.greyColor,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    cubit.netSavings >= 0
                        ? AppColors.kPrimaryColor
                        : AppColors.expense,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
