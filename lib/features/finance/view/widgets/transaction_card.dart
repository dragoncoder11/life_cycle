import 'package:flutter/material.dart';
import 'package:life_cycle/core/helper/spacing.dart';
import 'package:life_cycle/core/routing/routes.dart';
import 'package:life_cycle/core/theme/app_colors.dart';
import 'package:life_cycle/core/theme/app_text_styles.dart';
import 'package:life_cycle/core/widgets/custom_circle_avatar.dart';
import 'package:life_cycle/features/finance/data/models/transaction_model.dart';

class TransactionCard extends StatelessWidget {
  const TransactionCard({super.key, required this.transactionModel});
  final TransactionModel transactionModel;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.editTaskScreen,
        ); //arguments: TaskModel//
      },
      child: Card(
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CustomCircleAvatar(
                    color: transactionModel.category.iconColor.withOpacity(.3),
                    icon: transactionModel.category.icon,
                    iconColor: transactionModel.category.iconColor,
                  ),
                  horizontalSpace(10),
                  (transactionModel.note == '' || transactionModel.note == null)
                      ? Text(
                          transactionModel.category.name,
                          style: AppTextStyles.interBlack(12, FontWeight.bold),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              transactionModel.category.name,
                              style: AppTextStyles.interBlack(
                                11,
                                FontWeight.bold,
                              ),
                            ),
                            Text(
                              transactionModel.note!,
                              style: AppTextStyles.interGrey(
                                10,
                                FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                ],
              ),
              Column(crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${transactionModel.type == TransactionType.expense ? '+' : '-'} ${transactionModel.amount .toStringAsFixed(0)} EGP',
                    style: transactionModel.type == TransactionType.expense
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
