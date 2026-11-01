import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:life_cycle/core/helper/spacing.dart';
import 'package:life_cycle/core/theme/app_colors.dart';
import 'package:life_cycle/core/theme/app_text_styles.dart';
import 'package:life_cycle/core/widgets/custom_circle_avatar.dart';

import 'package:life_cycle/features/finance/data/models/transaction_model.dart';
import 'package:life_cycle/features/finance/logic/cubit/finance_cubit.dart';
import 'package:life_cycle/features/finance/logic/cubit/finance_state.dart';
import 'package:life_cycle/features/finance/logic/cubit/transaction_categories_cubit.dart';

import 'package:life_cycle/features/finance/view/screens/add_transaction_screen.dart';
import 'package:life_cycle/features/finance/view/screens/add_balance_screen.dart';

import 'package:life_cycle/features/finance/view/widgets/balance_card.dart';
import 'package:life_cycle/features/finance/view/widgets/income_extend_card.dart';
import 'package:life_cycle/features/finance/view/widgets/monthly_summary.dart';
import 'package:life_cycle/features/finance/view/widgets/finance_month_filter.dart';
import 'package:life_cycle/features/finance/view/widgets/transaction_item.dart';
import 'package:life_cycle/features/finance/view/widgets/initial_balance_dialog.dart';

class FinanceScreen extends StatelessWidget {
  const FinanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FinanceCubit, FinanceState>(
      builder: (context, state) {
        final cubit = context.read<FinanceCubit>();

        // Show Initial Balance Dialog once.
        if (!state.isLoading && !state.isInitialBalanceSet) {
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            if (!context.mounted) return;

            final shouldShow =
                await cubit.tryShowInitialBalanceDialog();

            if (!context.mounted || !shouldShow) return;

            await showInitialBalanceDialog(context, cubit);
          });
        }

        if (state.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final now = DateTime.now();

        final isCurrentMonth =
            state.selectedMonth.year == now.year &&
            state.selectedMonth.month == now.month;

        final isPastMonth =
            state.selectedMonth.year < now.year ||
            (state.selectedMonth.year == now.year &&
                state.selectedMonth.month < now.month);

        final visibleType = state.visibleTransactionType;

        final transactionsToShow = isCurrentMonth
            ? cubit.selectedMonthTransactions
            : cubit.visibleTransactions;

        return SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
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
                        final financeCubit =
                            context.read<FinanceCubit>();

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) {return MultiBlocProvider(
                                providers: [
                                  BlocProvider<FinanceCubit>.value(
                                    value: financeCubit,
                                  ),
                                  BlocProvider<
                                      TransactionCategoriesCubit>(
                                    create: (_) =>
                                        TransactionCategoriesCubit(),
                                  ),
                                ],
                                child: const AddTransactionScreen(),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),

                verticalSpace(12.h),

                // Current Balance
                GestureDetector(
                  onTap: () {
                    final financeCubit =
                        context.read<FinanceCubit>();

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BlocProvider.value(
                          value: financeCubit,
                          child: const AddBalanceScreen(),
                        ),
                      ),
                    );
                  },
                  child: BalanceCard(
                    balance: cubit.currentBalance,
                  ),
                ),

                verticalSpace(6.h),

                // Month Filter
                const MonthFilter(),

                verticalSpace(6.h),

                // Monthly Summary
                const MonthlySummary(),

                verticalSpace(8.h),

                // Income and Expenses Cards
                Row(
                  children: [
                    Expanded(
                      child: IncomeExtendCard(
                        cardColor:
                            AppColors.kPrimaryColor.withOpacity(.3),
                        icon: Icons.arrow_upward,
                        iconColor: AppColors.kPrimaryColor,
                        circleColor: AppColors.income,
                        title: 'Income',
                        price: cubit.monthlyIncome,
                        titleStyle: AppTextStyles.interDarkGreen(
                          11,
                          FontWeight.w500,
                        ),
                        priceStyle: AppTextStyles.interLightGreen(
                          12,
                          FontWeight.bold,
                        ),
                        showViewAll: isPastMonth &&
                            cubit.hasTransactionsOfType(
                              TransactionType.income,
                            ),
                        onViewAll: () {
                          cubit.toggleTransactions(
                            TransactionType.income,
                          );
                        },
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
                        cardColor:
                            AppColors.expense.withOpacity(.4),
                        icon: Icons.arrow_downward,
                        iconColor: AppColors.error,
                        circleColor: AppColors.expense,
                        title: 'Expenses',price: cubit.monthlyExpenses,
                        titleStyle: AppTextStyles.interRed(
                          11,
                          FontWeight.w500,
                        ),
                        priceStyle: AppTextStyles.interRed(
                          12,
                          FontWeight.bold,
                        ),
                        showViewAll: isPastMonth &&
                            cubit.hasTransactionsOfType(
                              TransactionType.expense,
                            ),
                        onViewAll: () {
                          cubit.toggleTransactions(
                            TransactionType.expense,
                          );
                        },
                      ),
                    ),
                  ],
                ),

                // Transactions List
                if (transactionsToShow.isNotEmpty) ...[
                  verticalSpace(10.h),

                  Text(
                    isCurrentMonth
                        ? 'Transactions'
                        : visibleType == TransactionType.income
                            ? 'Income Transactions'
                            : 'Expense Transactions',
                    style: AppTextStyles.interBlack(
                      18,
                      FontWeight.bold,
                    ),
                  ),

                  verticalSpace(4.h),

                  ...transactionsToShow.map(
                    (transaction) => Padding(
                      padding: EdgeInsets.only(bottom: 10.h),
                      child: TransactionItem(
                        transactionModel: transaction,
                      ),
                    ),
                  ),
                ],

                verticalSpace(20.h),
              ],
            ),
          ),
        );
      },
    );
  }
}