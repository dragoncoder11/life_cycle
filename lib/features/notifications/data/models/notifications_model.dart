import 'package:life_cycle/features/finance/data/models/transaction_model.dart';
import 'package:life_cycle/features/tasks/data/models/task_model.dart';

class NotificationsModel {
  final TaskModel? taskModel;
  final TransactionModel? transactionModel;

  NotificationsModel({this.taskModel, this.transactionModel});
}
