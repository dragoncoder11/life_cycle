
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_cycle/core/helper/spacing.dart';
import 'package:life_cycle/core/theme/app_colors.dart';
import 'package:life_cycle/core/widgets/custom_category_card.dart';
import 'package:life_cycle/features/finance/logic/cubit/transaction_categories_cubit.dart';

class ChangeBetweenIncomeExtendCards extends StatelessWidget {
  const ChangeBetweenIncomeExtendCards({
    super.key,
    required this.cubit,
  });

  final TransactionCategoriesCubit cubit;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                cubit.changeType('Expense');
              },
              child: CustomCategoryCard(
                title: 'Expense',
                color: cubit.selectedType == 'Expense'
                    ? AppColors.kPrimaryColor
                    : AppColors.switchTrackOff,
              ),
            ),
          ),
          horizontalSpace(8.w),
          Expanded(
            child: GestureDetector(
              onTap: () {
                cubit.changeType('Income');
              },
              child: CustomCategoryCard(
                title: 'Income',
                color: cubit.selectedType == 'Income'
                    ? AppColors.kPrimaryColor
                    : AppColors.switchTrackOff,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

