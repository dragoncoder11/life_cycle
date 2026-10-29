import 'package:flutter/material.dart';
import 'package:life_cycle/core/helper/spacing.dart';
import 'package:life_cycle/core/routing/routes.dart';
import 'package:life_cycle/core/theme/app_colors.dart';
import 'package:life_cycle/core/theme/app_text_styles.dart';
import 'package:life_cycle/features/tasks/data/models/task_model.dart';
import 'package:intl/intl.dart';

class TaskItemCompleted extends StatelessWidget {
  const TaskItemCompleted({super.key, required this.taskModel});
  final TaskModel taskModel;
  @override
  Widget build(BuildContext context) {
    //final startTime = DateFormat('hh:mm a', 'en').format(taskModel.endTime);

    final endTime = DateFormat('hh:mm a', 'en').format(taskModel.endTime);

    final dayName = DateFormat('EEE', 'en').format(taskModel.endTime);

    final dayNumber = DateFormat('dd', 'en').format(taskModel.endTime);

    final monthName = DateFormat('MMM', 'en').format(taskModel.endTime);
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.editTaskScreen,
        ); //arguments: TaskModel//
      },
      child: Card(
        elevation: 3,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.textHint,
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.expense,
                            width: 2,
                          ),
                        ),
                      ),
                      horizontalSpace(8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              taskModel.title,
                              style: AppTextStyles.interBlack(
                                18,
                                FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            verticalSpace(8),
                            Row(
                              children: [
                                const Icon(Icons.date_range, size: 16),
                                horizontalSpace(4),
                                Flexible(
                                  child: Text(
                                    '$endTime',
                                    style: AppTextStyles.interRed(
                                      11,
                                      FontWeight.w400,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                horizontalSpace(8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Icon(Icons.more_vert),
                    verticalSpace(12),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '$dayName ',
                            style: AppTextStyles.interGrey(11, FontWeight.w600),
                          ),
                          TextSpan(
                            text: '$dayNumber ',
                            style: AppTextStyles.interGrey(11, FontWeight.w600),
                          ),
                          TextSpan(
                            text: monthName,
                            style: AppTextStyles.interRed(
                              11,
                              FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      maxLines: 1,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
