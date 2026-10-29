
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
        final tasks = List.of(context.read<TasksCubit>().tasks ?? []);

        // الأحدث حسب موعد المهمة يظهر أولًا
        tasks.sort((a, b) => b.endTime.compareTo(a.endTime));

        return ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            final task = tasks[index];

            final isTimeCompleted =
                !task.endTime.isAfter(DateTime.now());

            if (isTimeCompleted) {
              return TaskItemCompleted(taskModel: task);
            }

            return TaskItem(taskModel: task);
          },
        );
      },
    );
  }
}
