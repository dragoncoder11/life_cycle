import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_cycle/core/helper/spacing.dart';
import 'package:life_cycle/core/theme/app_colors.dart';
import 'package:life_cycle/core/theme/app_text_styles.dart';
import 'package:life_cycle/core/widgets/custom_circle_avatar.dart';
import 'package:life_cycle/features/finance/view/widgets/balance_card.dart';
import 'package:life_cycle/features/finance/view/widgets/income_extend_card.dart';

class FinanceScreen extends StatelessWidget {
  const FinanceScreen({super.key});

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
                'Finance',
                style: AppTextStyles.interBlack(24, FontWeight.bold),
              ),
              CustomCircleAvatar(icon: Icons.add, onPressed: () {}),
            ],
          ),
          verticalSpace(12.h),
          BalanceCard(),
          verticalSpace(12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IncomeExtendCard(
                cardColor: AppColors.kPrimaryColor.withOpacity(.3),
                icon: Icons.arrow_upward,
                iconColor: AppColors.kPrimaryColor,
                circleColor: AppColors.income,
                title: 'Income',
                price: 2500,
                titleStyle: AppTextStyles.interDarkGreen(11, FontWeight.w500),
                priceStyle: AppTextStyles.interDarkGreen(12, FontWeight.bold),
              ),
              Icon(
                Icons.currency_exchange,
                size: 32.r,
                color: AppColors.kPrimaryColor,
              ),
              IncomeExtendCard(
                cardColor: AppColors.expense.withOpacity(.4),
                icon: Icons.arrow_downward,
                iconColor: AppColors.error,
                circleColor: AppColors.expense,
                title: 'Expenses',
                price: 700,
                titleStyle: AppTextStyles.interRed(11, FontWeight.w500),
                priceStyle: AppTextStyles.interRed(12, FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
