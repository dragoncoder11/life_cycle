
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_cycle/core/widgets/custom_circle_avatar.dart';
import 'package:life_cycle/features/tasks/logic/add_task/add_task_cubit.dart';
import 'package:life_cycle/features/tasks/logic/get_tasks/tasks_cubit.dart';
import 'package:life_cycle/features/tasks/view/widgets/show_task_model_sheet_body.dart';

class AddTaskSheet extends StatelessWidget {
  const AddTaskSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCircleAvatar(
      icon: Icons.add,
      onPressed: () {
        final tasksCubit = context.read<TasksCubit>();
    
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          useSafeArea: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(16),
            ),
          ),
          builder: (context) {
            return MultiBlocProvider(
              providers: [
                BlocProvider(create: (_) => AddTaskCubit()),
                BlocProvider.value(value: tasksCubit),
              ],
              child: AnimatedPadding(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOut,
                padding: EdgeInsets.only(
                  bottom: MediaQuery.viewInsetsOf(context).bottom,
                ),
                child: const ShowTaskModelSheetBody(),
              ),
            );
          },
        );
      },
    );
  }
}
