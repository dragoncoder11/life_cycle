import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_cycle/core/helper/spacing.dart';
import 'package:life_cycle/core/theme/app_colors.dart';
import 'package:life_cycle/core/theme/app_text_styles.dart';
import 'package:life_cycle/features/tasks/logic/get_tasks/tasks_cubit.dart';
import 'package:life_cycle/features/tasks/view/widgets/add_task_sheet.dart';
import 'package:life_cycle/features/tasks/view/widgets/task_categories_row.dart';
import 'package:life_cycle/features/tasks/view/widgets/tasks_listview.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          verticalSpace(12.h),
          BlocBuilder<TasksCubit, TasksState>(
            builder: (context, state) {
              var cubit = context.read<TasksCubit>();
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                   cubit.isSelectionMode ? '${cubit.selectedTasks.length} Selected' : 'Tasks',
                    style: AppTextStyles.interBlack(24, FontWeight.bold),
                  ),

                    if (cubit.isSelectionMode) ...[
                      IconButton(
                        onPressed: () async {
                          await cubit.deleteSelectedTasks();
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),

                      IconButton(
                        onPressed: () {
                          cubit.clearSelection();
                        },
                        icon: const Icon(
                          Icons.close,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ] else
                      const AddTaskSheet(),
                ],
              );
            },
          ),
          verticalSpace(12.h),

          BlocBuilder<TasksCubit, TasksState>(
            builder: (context, state) {
              var cubit = context.read<TasksCubit>();
              return TaskCategoriesRow();
            },
          ),
          verticalSpace(12.h),
          Expanded(child: TasksListview()),
        ],
      ),
    );
  }
}
