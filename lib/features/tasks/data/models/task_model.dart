class TaskModel {
  final String title;
  final String? date;  // this for date time .now i will use to get the day and the month
  final DateTime startTime;
  final DateTime endTime;
  final bool isCompleted;

  TaskModel({required this.title, this.date, required this.startTime, required this.endTime, required this.isCompleted});

}
