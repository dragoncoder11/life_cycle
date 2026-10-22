import 'package:flutter/material.dart';
import 'package:life_cycle/features/finance/data/models/transaction_model.dart';
import 'package:life_cycle/features/finance/data/models/transaction_category_model.dart';

final List<TransactionModel> transactions = [
  TransactionModel(
    id: '1',
    title: 'Monthly Salary',
    amount: 15000,
    type: TransactionType.income,
    category: const TransactionCategoryModel(
      id: 'salary',
      name: 'Salary',
      icon: Icons.work_outline,
      iconColor: Colors.green,
    ),
    date: DateTime(2026, 10, 1),
    note: 'October salary',
  ),

  TransactionModel(
    id: '2',
    title: 'Grocery Shopping',
    amount: 1200,
    type: TransactionType.expense,
    category: const TransactionCategoryModel(
      id: 'shopping',
      name: 'Shopping',
      icon: Icons.shopping_bag_outlined,
      iconColor: Colors.orange,
    ),
    date: DateTime(2026, 10, 5),
    note: 'Weekly groceries',
  ),

  TransactionModel(
    id: '3',
    title: 'Freelance Project',
    amount: 3000,
    type: TransactionType.income,
    category: const TransactionCategoryModel(
      id: 'freelance',
      name: 'Freelance',
      icon: Icons.laptop_mac,
      iconColor: Colors.blue,
    ),
    date: DateTime(2026, 10, 8),
    note: 'Mobile app project',
  ),

  TransactionModel(
    id: '4',
    title: 'Electricity Bill',
    amount: 450,
    type: TransactionType.expense,
    category: const TransactionCategoryModel(
      id: 'bills',
      name: 'Bills',
      icon: Icons.receipt_long,
      iconColor: Colors.red,
    ),
    date: DateTime(2026, 10, 10),
  ),

  TransactionModel(
    id: '5',
    title: 'Transportation',
    amount: 200,
    type: TransactionType.expense,
    category: const TransactionCategoryModel(
      id: 'transport',
      name: 'Transport',
      icon: Icons.directions_car_outlined,
      iconColor: Colors.purple,
    ),
    date: DateTime(2026, 10, 12),
  ),

  TransactionModel(
    id: '6',
    title: 'Online Course',
    amount: 600,
    type: TransactionType.expense,
    category: const TransactionCategoryModel(
      id: 'education',
      name: 'Education',
      icon: Icons.school_outlined,
      iconColor: Colors.teal,
    ),
    date: DateTime(2026, 10, 15),
    note: 'Flutter course',
  ),
];