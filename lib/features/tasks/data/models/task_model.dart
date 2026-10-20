class TaskModel {
  final String title;
  final DateTime? date;
  final DateTime startTime;
  final DateTime endTime;
  final bool isCompleted;

  TaskModel({required this.title, this.date, required this.startTime, required this.endTime, required this.isCompleted});

}
