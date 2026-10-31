
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:life_cycle/core/helper/app_constants.dart';
import 'package:life_cycle/features/tasks/data/models/task_model.dart';
import 'package:meta/meta.dart';

part 'tasks_state.dart';

class TasksCubit extends Cubit<TasksState> {
  TasksCubit() : super(TasksInitial()) {
    startTasksTimer();
  }

  int selectedIndex = 0;

  List<TaskModel> tasks = [];

  Timer? tasksTimer;

  // تغيير Category
  void changeIndex(int index) {
    if (selectedIndex == index) return;

    selectedIndex = index;

    emit(IndexChanged());
  }

  // جلب المهام من Hive
  void fetchTasks() {
    final tasksBox = Hive.box<TaskModel>(kTasksBox);

    tasks = tasksBox.values.toList();

    emit(TasksSuccess());
  }

  // تحديث الشاشة تلقائياً كل ثانية
  void startTasksTimer() {
    tasksTimer?.cancel();

    tasksTimer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        emit(TasksChangesBetweenCategories());
      },
    );
  }

  // إيقاف التحديث عند إغلاق Cubit
  @override
  Future<void> close() {
    tasksTimer?.cancel();

    return super.close();
  }
}
