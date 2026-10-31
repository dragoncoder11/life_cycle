
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:life_cycle/core/helper/spacing.dart';
import 'package:life_cycle/core/routing/routes.dart';
import 'package:life_cycle/core/theme/app_colors.dart';
import 'package:life_cycle/core/theme/app_text_styles.dart';
import 'package:life_cycle/core/widgets/custom_circle_avatar.dart';

import 'package:life_cycle/features/finance/data/models/transaction_model.dart';
import 'package:life_cycle/features/finance/view/widgets/balance_card.dart';
import 'package:life_cycle/features/finance/view/widgets/income_extend_card.dart';
import 'package:life_cycle/features/finance/view/widgets/transaction_item.dart';
import 'package:life_cycle/features/finance/view/widgets/transaction_list.dart';

class FinanceScreen extends StatelessWidget {
  const FinanceScreen({super.key});

  double get totalExpenses {
    return transactions
        .where(
          (transaction) =>
              transaction.type == TransactionType.income,
        )
        .fold(
          0.0,
          (sum, transaction) => sum + transaction.amount,
        );
  }

  double get totalIncome {
    return transactions
        .where(
          (transaction) =>
              transaction.type == TransactionType.expense,
        )
        .fold(
          0.0,
          (sum, transaction) => sum + transaction.amount,
        );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          verticalSpace(12.h),

          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Finance',
                style: AppTextStyles.interBlack(
                  24,
                  FontWeight.bold,
                ),
              ),
              CustomCircleAvatar(
                icon: Icons.add,
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    Routes.addTransactionScreen,
                  );
                },
              ),
            ],
          ),

          verticalSpace(12.h),

          // Balance
          const BalanceCard(),

          verticalSpace(12.h),

          // Income and Expenses
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: IncomeExtendCard(
                  cardColor:
                      AppColors.kPrimaryColor.withOpacity(.3),
                  icon: Icons.arrow_upward,
                  iconColor: AppColors.kPrimaryColor,
                  circleColor: AppColors.income,
                  title: 'Income',
                  price: totalIncome,
                  titleStyle: AppTextStyles.interDarkGreen(
                    11,
                    FontWeight.w500,
                  ),
                  priceStyle: AppTextStyles.interLightGreen(
                    12,
                    FontWeight.bold,
                  ),
                ),
              ),

              horizontalSpace(8.w),

              Icon(
                Icons.currency_exchange,
                size: 32.r,
                color: AppColors.kPrimaryColor,
              ),

              horizontalSpace(8.w),

              Expanded(
                child: IncomeExtendCard(
                  cardColor: AppColors.expense.withOpacity(.4),
                  icon: Icons.arrow_downward,
                  iconColor: AppColors.error,
                  circleColor: AppColors.expense,
                  title: 'Expenses',
                  price: totalExpenses,
                  titleStyle: AppTextStyles.interRed(
                    11,
                    FontWeight.w500,
                  ),
                  priceStyle: AppTextStyles.interRed(
                    12,
                    FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          verticalSpace(10.h),

          // Transactions List
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                return TransactionItem(
                  transactionModel: transactions[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
