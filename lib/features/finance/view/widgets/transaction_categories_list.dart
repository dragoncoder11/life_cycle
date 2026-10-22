import 'package:flutter/material.dart';
import 'package:life_cycle/features/finance/data/models/transaction_category_model.dart';

class TransactionCategories {
  static const expensesCategories = [
    TransactionCategoryModel(
      id: 'food',
      name: 'Food',
      icon: Icons.restaurant,
      iconColor: Color(0xFFFFB74D),
    ),
    TransactionCategoryModel(
      id: 'transport',
      name: 'Transport',
      icon: Icons.directions_bus,
      iconColor: Color.fromARGB(255, 200, 69, 21),
    ),
    TransactionCategoryModel(
      id: 'bills',
      name: 'Bills',
      icon: Icons.receipt_long,
      iconColor: Color(0xFF7986CB),
    ),
    TransactionCategoryModel(
      id: 'shopping',
      name: 'Shopping',
      icon: Icons.shopping_bag,
      iconColor: Color(0xFFE57373),
    ),
    TransactionCategoryModel(
      id: 'health',
      name: 'Health',
      icon: Icons.medical_services,
      iconColor: Color(0xFF66BB6A),
    ),
    TransactionCategoryModel(
      id: 'education',
      name: 'Education',
      icon: Icons.school,
      iconColor: Color(0xFF9575CD),
    ),
    TransactionCategoryModel(
      id: 'entertainment',
      name: 'Entertainment',
      icon: Icons.sports_esports,
      iconColor: Color(0xFF42A5F5),
    ),
    TransactionCategoryModel(
      id: 'other',
      name: 'Other',
      icon: Icons.more_horiz,
      iconColor: Color(0xFF78909C),
    ),
  ];

  static const incomesCategories = [
    TransactionCategoryModel(
      id: 'salary',
      name: 'Salary',
      icon: Icons.account_balance_wallet,
      iconColor: Color(0xFF168675),
    ),
    TransactionCategoryModel(
      id: 'freelance',
      name: 'Freelance',
      icon: Icons.laptop,
      iconColor: Color(0xFF5C6BC0),
    ),
    TransactionCategoryModel(
      id: 'business',
      name: 'Business',
      icon: Icons.store,
      iconColor: Color(0xFF26A69A),
    ),
    TransactionCategoryModel(
      id: 'investment',
      name: 'Investment',
      icon: Icons.trending_up,
      iconColor: Color(0xFFFFB74D),
    ),
    TransactionCategoryModel(
      id: 'gift',
      name: 'Gift',
      icon: Icons.card_giftcard,
      iconColor: Color(0xFFEC6A8B),
    ),
    TransactionCategoryModel(
      id: 'bonus',
      name: 'Bonus',
      icon: Icons.monetization_on,
      iconColor: Color(0xFF66BB6A),
    ),
    TransactionCategoryModel(
      id: 'rental',
      name: 'Rental',
      icon: Icons.home,
      iconColor: Color(0xFF7986CB),
    ),
    TransactionCategoryModel(
      id: 'other',
      name: 'Other',
      icon: Icons.more_horiz,
      iconColor: Color(0xFF78909C),
    ),
  ];
}