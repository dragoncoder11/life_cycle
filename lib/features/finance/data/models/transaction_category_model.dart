import 'package:flutter/material.dart';

class TransactionCategoryModel {
  final String id;
  final String name;
  final IconData icon;
  final Color iconColor;

  const TransactionCategoryModel({
    required this.id,
    required this.name,
    required this.icon,
    required this.iconColor,
  });
}