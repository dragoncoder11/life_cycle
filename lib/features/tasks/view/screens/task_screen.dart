import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_cycle/core/helper/spacing.dart';
import 'package:life_cycle/core/theme/app_colors.dart';
import 'package:life_cycle/features/tasks/logic/get_tasks/tasks_cubit.dart';
import 'package:life_cycle/features/tasks/view/widgets/add_task_sheet.dart';
import 'package:life_cycle/features/tasks/view/widgets/task_categories_row.dart';
import 'package:life_cycle/features/tasks/view/widgets/tasks_listview.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return BlocBuilder<TasksCubit, TasksState>(
      builder: (context, state) {
        var cubit = context.read<TasksCubit>();
        return PopScope(
          canPop: !cubit.isSelectionMode,
          onPopInvokedWithResult: (didPop, result) {
            if (!didPop && cubit.isSelectionMode) {
              cubit.clearSelection();
            }
          },
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpace(12.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      cubit.isSelectionMode
                          ? '${cubit.selectedTasks.length} Selected'
                          : 'Tasks',
                      style: Theme.of(context).textTheme.displaySmall,
                    ),

                    if (cubit.isSelectionMode) ...[
                      IconButton(
                        onPressed: () async {
                          await cubit.deleteSelectedTasks();
                        },
                        icon: const Icon(Icons.delete, color: Colors.red),
                      ),

                      IconButton(
                        onPressed: () {
                          cubit.clearSelection();
                        },
                        icon: Icon(
                          Icons.close,
                          color:isDark?AppColors.whiteColor: AppColors.darkGreenColor,
                        ),
                      ),
                    ] else
                      const AddTaskSheet(),
                  ],
                ),

                verticalSpace(12.h),
                TaskCategoriesRow(),
                verticalSpace(4.h),
                Expanded(child: TasksListview()),
              ],
            ),
          ),
        );
      },
    );
  }
}
