
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_cycle/core/helper/spacing.dart';
import 'package:life_cycle/core/theme/app_colors.dart';
import 'package:life_cycle/core/theme/app_text_styles.dart';
import 'package:life_cycle/core/widgets/custom_circle_avatar.dart';
import 'package:life_cycle/features/finance/data/models/transaction_category_model.dart';

class TransactionCategory extends StatelessWidget {
  const TransactionCategory({
    super.key,
    required this.category,
    required this.isSelected,
    required this.onTap,
  });

  final TransactionCategoryModel category;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final Color categoryColor =
        isSelected ? category.iconColor : Colors.grey;

    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 60.r,
            height: 60.r,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.background,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.12),
                    blurRadius: 8,
                    spreadRadius: 1,
                    offset: const Offset(0, 3),
                  ),
                ],
                border: isSelected
                    ? Border.all(
                        color: category.iconColor,
                        width: 2,
                      )
                    : null,
              ),
              child: CustomCircleAvatar(
                color: AppColors.background,
                iconColor: categoryColor,
                icon: category.icon,
                iconSize: 30.r,
              ),
            ),
          ),
          verticalSpace(3),
          Text(
            category.name,
            style: AppTextStyles.interDarkGreen(
              10,
              FontWeight.w500,
            ).copyWith(color: categoryColor),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
