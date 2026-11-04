import 'package:flutter/material.dart';
import 'package:life_cycle/core/theme/app_colors.dart';
import 'package:life_cycle/features/home/data/models/home_card_model.dart';

List<HomeCardModel> homeCards = [
  HomeCardModel(
    icon: Icons.edit_note,
    title: 'Notes',
    color: AppColors.kPrimaryColor,
    subTitle: 'Your thoughts and ideas',
  ), 
  HomeCardModel(
    icon: Icons.pending_actions,
    title: 'Tasks',
    color: AppColors.blueColor,
    subTitle: 'Plan and organize',
  ),

  HomeCardModel(
    icon: Icons.wallet,
    title: 'Finance',
    color: AppColors.financeYellow,
    subTitle: 'Track your money',
  ),
  HomeCardModel(
    icon: Icons.bedtime,
    title: 'Prayer',
    color: AppColors.purpleColor,
    subTitle: 'Stay on track',
  ), 
];
