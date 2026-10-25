import 'package:life_cycle/features/tasks/data/models/task_model.dart';

final List<TaskModel> tasks = [
  TaskModel(
    title: 'Read a book',
    date: '2026-10-25',
    startTime: DateTime(2026, 10, 25, 9, 0),
    endTime: DateTime(2026, 10, 25, 10, 0),
    isCompleted: false,
  ),
  TaskModel(
    title: 'Workout',
    date: '2026-10-25',
    startTime: DateTime(2026, 10, 25, 11, 0),
    endTime: DateTime(2026, 10, 25, 12, 0),
    isCompleted: true,
  ),
  TaskModel(
    title: 'Learn Flutter',
    date: '2026-10-25',
    startTime: DateTime(2026, 10, 25, 14, 0),
    endTime: DateTime(2026, 10, 25, 16, 0),
    isCompleted: false,
  ),
  TaskModel(
    title: 'Complete project',
    date: '2026-10-26',
    startTime: DateTime(2026, 10, 26, 10, 0),
    endTime: DateTime(2026, 10, 26, 12, 0),
    isCompleted: false,
  ),
  TaskModel(
    title: 'Watch a Flutter tutorial',
    date: '2026-10-26',
    startTime: DateTime(2026, 10, 26, 15, 0),
    endTime: DateTime(2026, 10, 26, 16, 30),
    isCompleted: true,
  ),
];