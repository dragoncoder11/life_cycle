import 'package:bloc/bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:life_cycle/core/helper/app_constants.dart';
import 'package:life_cycle/features/tasks/data/models/task_model.dart';
import 'package:meta/meta.dart';

part 'tasks_state.dart';
class TasksCubit extends Cubit<TasksState> {
  TasksCubit() : super(TasksInitial()) {
   // fetchTasks();
  }

  int selectedIndex = 0;

  List<TaskModel> tasks = [];

  void changeIndex(int index) {
    selectedIndex = index;
    emit(IndexChanged());
  }

  void fetchTasks() {
    final tasksBox = Hive.box<TaskModel>(kTasksBox);
    tasks = tasksBox.values.toList();
    emit(TasksSuccess());
  }
}