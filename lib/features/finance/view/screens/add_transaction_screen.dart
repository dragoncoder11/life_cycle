import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_cycle/core/helper/spacing.dart';
import 'package:life_cycle/core/theme/app_colors.dart';
import 'package:life_cycle/core/theme/app_text_styles.dart';
import 'package:life_cycle/features/finance/logic/cubit/transaction_categories_cubit.dart';
import 'package:life_cycle/features/finance/view/widgets/change_between_income_extend_cards.dart';
import 'package:life_cycle/features/finance/view/widgets/list_of_transaction_fields.dart';
import 'package:life_cycle/features/finance/view/widgets/transaction_categories_grid.dart';
import 'package:life_cycle/features/finance/view/widgets/transaction_categories_list.dart';

class AddTransactionScreen extends StatelessWidget {
  const AddTransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionCategoriesCubit, TransactionCategoriesState>(
      builder: (context, state) {
        final cubit = context.read<TransactionCategoriesCubit>();
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: CustomScrollView(
                physics: BouncingScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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

                        verticalSpace(10.h),

                        Text(
                          'Add Transaction',
                          style: AppTextStyles.interBlack(24, FontWeight.bold),
                        ),

                        verticalSpace(16.h),

                        ChangeBetweenIncomeExtendCards(cubit: cubit),
                        verticalSpace(10.h),
                      ],
                    ),
                  ),

                  cubit.selectedType == 'Expense'
                      ? TransactionCategoriesGrid(cubit: cubit, count: TransactionCategories.expensesCategories.length, category: TransactionCategories
                                  .expensesCategories,)
                      : TransactionCategoriesGrid(cubit: cubit, count: TransactionCategories.incomesCategories.length, category: TransactionCategories
                                  .incomesCategories,),
                  ListOfTransactionFields(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
