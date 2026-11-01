import 'package:hive/hive.dart';
import 'package:life_cycle/features/finance/data/models/transaction_category_model.dart';


@HiveType(typeId: 3)
enum TransactionType {
  @HiveField(0)
  income,

  @HiveField(1)
  expense,
}

@HiveType(typeId: 4)
class TransactionModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final double amount;

  @HiveField(3)
  final TransactionType type;

  @HiveField(4)
  final TransactionCategoryModel category;

  @HiveField(5)
  final DateTime date;

  @HiveField(6)
  final String? note;

  const TransactionModel({
    required this.id,
    required this.title,
    required this.amount,
    required this.type,
    required this.category,
    required this.date,
    this.note,
  });
}