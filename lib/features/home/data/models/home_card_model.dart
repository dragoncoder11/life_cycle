import 'package:flutter/material.dart';

class HomeCardModel {
  final IconData icon;
  final String title;
  final String subTitle;
  final Color color;
  final Function? onTap;

  HomeCardModel({
    required this.icon,
    required this.title,
    required this.color,
    this.onTap,
    required this.subTitle,
  });
}
