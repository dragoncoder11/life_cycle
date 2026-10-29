
import 'package:hive/hive.dart';

part 'task_model.g.dart';

@HiveType(typeId: 2)
class TaskModel extends HiveObject {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String? date;

  @HiveField(2)
  final DateTime endTime;

  @HiveField(3)
  final bool? isCompleted;

  TaskModel({
    required this.title,
    this.date,
    required this.endTime,
    this.isCompleted,
  });
}
