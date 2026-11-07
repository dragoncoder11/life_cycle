import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_cycle/core/helper/spacing.dart';
import 'package:life_cycle/core/theme/app_colors.dart';
import 'package:life_cycle/features/tasks/data/models/task_model.dart';
import 'package:intl/intl.dart';
import 'package:life_cycle/features/tasks/logic/get_tasks/tasks_cubit.dart';

class TaskItemCompleted extends StatelessWidget {
  const TaskItemCompleted({super.key, required this.taskModel});
  final TaskModel taskModel;
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    var cubit = context.read<TasksCubit>();
    bool isSelected = cubit.isTaskSelected(taskModel);
    //final startTime = DateFormat('hh:mm a', 'en').format(taskModel.endTime);

    final endTime = DateFormat('hh:mm a', 'en').format(taskModel.endTime!);

    final dayName = DateFormat('EEE', 'en').format(taskModel.endTime!);

    final dayNumber = DateFormat('dd', 'en').format(taskModel.endTime!);

    final monthName = DateFormat('MMM', 'en').format(taskModel.endTime!);
    return GestureDetector(
      onLongPress: () {
        cubit.toggleTaskSelection(taskModel);
      },
      onTap: () {
        if (cubit.isSelectionMode) {
          cubit.toggleTaskSelection(taskModel);
        } else {
          // Handle tap when not in selection mode
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Card(
          elevation: 3,
          child: Container(
            decoration: BoxDecoration(
              color: isSelected
                  ? Colors.red.withOpacity(0.15)
                  : AppColors.greyColor,
              border: Border.all(
                color: isSelected ? Colors.red : Colors.transparent,
                width: 1.5,
              ),
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
                              color: AppColors.blackColor,
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
                                taskModel.title!,
                          style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 18.sp),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              verticalSpace(8),
                              Row(
                                children: [
                                   Icon(
                                    Icons.date_range,
                                    size: 16,
                                    color:isDark?AppColors.whiteColor: AppColors.blackColor,
                                  ),
                                  horizontalSpace(4),

                                  Expanded(
                                    child: Text(
                                      endTime,
                                      style:Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 11.sp),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: '$dayName ',
                                          style:Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 11.sp),
                                        ),
                                        TextSpan(
                                          text: '$dayNumber ',
                                          style:Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 11.sp),
                                        ),
                                        TextSpan(
                                          text: monthName,
                                          style:Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 11.sp),
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
                        if (isSelected)
                          const Icon(
                            Icons.check_circle,
                            color: Colors.red,
                            size: 24,
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
