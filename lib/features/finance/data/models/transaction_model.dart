import 'package:life_cycle/features/finance/data/models/transaction_category_model.dart';

enum TransactionType {
  income,
  expense,
}

class TransactionModel {
  final String id;
  final String title;
  final double amount;
  final TransactionType type;
  final TransactionCategoryModel category;
  final DateTime date;
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