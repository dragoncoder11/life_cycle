import 'package:flutter/material.dart';
import 'package:life_cycle/features/tasks/view/widgets/task_item.dart';
import 'package:life_cycle/features/tasks/view/widgets/tasks_list.dart';

class TasksListview extends StatelessWidget {
  const TasksListview({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(physics: BouncingScrollPhysics(),itemCount: tasks.length,itemBuilder: (context,index){
      return TaskItem(taskModel: tasks[index],);
    });
  }
}