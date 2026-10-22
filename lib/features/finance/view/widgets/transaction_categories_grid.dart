import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_cycle/features/finance/logic/cubit/transaction_categories_cubit.dart';
import 'package:life_cycle/features/finance/view/widgets/transaction_category.dart';

class TransactionCategoriesGrid extends StatelessWidget {
  const TransactionCategoriesGrid({
    super.key,
    required this.cubit,
    required this.count,
    required this.category,
  });

  final TransactionCategoriesCubit cubit;
  final int count;
  final dynamic category;

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate((context, index) {
        final currentCategory = category[index];
        return Center(
          child: TransactionCategory(
            category: currentCategory,
            isSelected: cubit.selectedCategoryId == currentCategory.id,
            onTap: () {
              cubit.changeBetweenCategories(currentCategory.id);
            },
          ),
        );
      }, childCount: count),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 10.w,
        //  mainAxisSpacing: 4.h,
        childAspectRatio: 0.8,
      ),
    );
  }
}
