import 'package:flutter/material.dart';
import 'package:life_cycle/core/helper/spacing.dart';
import 'package:life_cycle/core/theme/app_colors.dart';
import 'package:life_cycle/core/theme/app_text_styles.dart';
import 'package:life_cycle/core/widgets/custom_circle_avatar.dart';
import 'package:life_cycle/features/finance/data/models/transaction_model.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({super.key, required this.transactionModel});
  final TransactionModel transactionModel;
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Card(
      elevation: 3,
      child: Container(
        decoration: BoxDecoration(
          color:isDark?AppColors.notificationCard: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color:isDark?AppColors.whiteColor.withValues(alpha: 0.08): AppColors.blackColor.withValues(alpha: 0.08),
              blurRadius: 2,
              spreadRadius: 1,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    CustomCircleAvatar(
                      color: transactionModel.category.iconColor.withOpacity(
                        .3,
                      ),
                      icon: transactionModel.category.icon,
                      iconColor: transactionModel.category.iconColor,
                    ),
                    horizontalSpace(10),
                    (transactionModel.note == '' ||
                            transactionModel.note == null)
                        ? Text(
                            transactionModel.category.name,
                            style:Theme.of(context).textTheme.titleLarge
                          )
                        : Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  transactionModel.category.name,
                                  style: Theme.of(context).textTheme.titleLarge
                                ),
                                Text(
                                  transactionModel.note!,
                                  style: AppTextStyles.interGrey(
                                    12,
                                    FontWeight.w500,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ],
                            ),
                          ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${transactionModel.type == TransactionType.income ? '+' : '-'} ${transactionModel.amount.toStringAsFixed(0)} EGP',
                    style: transactionModel.type == TransactionType.income
                        ? AppTextStyles.interBlack(
                            11,
                            FontWeight.bold,
                          ).copyWith(color: AppColors.kPrimaryColor)
                        : AppTextStyles.interRed(11, FontWeight.bold),
                  ),
                  Text(
                    '${transactionModel.date.day}/${transactionModel.date.month}/${transactionModel.date.year}',
                    style: AppTextStyles.interGrey(10, FontWeight.w500),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
