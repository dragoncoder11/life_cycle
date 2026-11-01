import 'package:flutter/material.dart';
import 'package:hive/hive.dart';


@HiveType(typeId: 2)
class TransactionCategoryModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final IconData icon;

  @HiveField(3)
  final Color iconColor;

  const TransactionCategoryModel({
    required this.id,
    required this.name,
    required this.icon,
    required this.iconColor,
  });
}