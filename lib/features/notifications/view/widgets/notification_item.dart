import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_cycle/core/helper/spacing.dart';
import 'package:life_cycle/core/theme/app_colors.dart';
import 'package:life_cycle/core/theme/app_text_styles.dart';
import 'package:life_cycle/core/widgets/custom_circle_avatar.dart';
import 'package:life_cycle/features/finance/data/models/transaction_model.dart';
import 'package:life_cycle/features/tasks/data/models/task_model.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({super.key, this.transactionModel, this.taskModel});
  final TransactionModel? transactionModel;
  final TaskModel? taskModel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 5.h),
      child: Card(
        elevation: 3,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 2,
                spreadRadius: 1,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                CustomCircleAvatar(
                  color: AppColors.kPrimaryColor,
                  icon: Icons.check,
                  iconColor: AppColors.background,
                ),
                horizontalSpace(12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'transactionModel',
                        style: AppTextStyles.interBlack(16, FontWeight.bold),
                      ),
                      Text(
                        'transactionModetransactionModel.notetransactionModel.notel.note!',
                        style: AppTextStyles.interGrey(12, FontWeight.w600),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        '10:00 AM',
                        style: AppTextStyles.interGrey(12, FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
