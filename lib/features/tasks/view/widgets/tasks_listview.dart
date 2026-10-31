
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_cycle/features/tasks/logic/get_tasks/tasks_cubit.dart';
import 'package:life_cycle/features/tasks/view/widgets/task_item.dart';
import 'package:life_cycle/features/tasks/view/widgets/task_item_completed.dart';

class TasksListview extends StatelessWidget {
  const TasksListview({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksCubit, TasksState>(
      builder: (context, state) {
        final cubit = context.read<TasksCubit>();

        final tasks = List.of(cubit.tasks);

        final now = DateTime.now();

        final today = DateTime(
          now.year,
          now.month,
          now.day,
        );

        final filteredTasks = tasks.where((task) {
          final taskDate = DateTime(
            task.endTime.year,
            task.endTime.month,
            task.endTime.day,
          );

          // Today
          if (cubit.selectedIndex == 0) {
            return taskDate == today &&
                task.isCompleted != true &&
                task.endTime.isAfter(now);
          }

          // Upcoming
          if (cubit.selectedIndex == 1) {
            return taskDate.isAfter(today) &&
                task.isCompleted != true;
          }

          // Completed
          if (cubit.selectedIndex == 2) {
            return task.isCompleted == true ||
                !task.endTime.isAfter(now);
          }

          return false;
        }).toList();

        filteredTasks.sort(
          (a, b) => b.endTime.compareTo(a.endTime),
        );

        return ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: filteredTasks.length,
          itemBuilder: (context, index) {
            final task = filteredTasks[index];

            if (cubit.selectedIndex == 2) {
              return TaskItemCompleted(
                taskModel: task,
              );
            }

            return TaskItem(
              taskModel: task,
            );
          },
        );
      },
    );
  }
}
