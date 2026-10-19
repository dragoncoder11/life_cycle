import 'package:flutter/material.dart';
import 'package:life_cycle/core/theme/app_colors.dart';
import 'package:life_cycle/features/button_nav_bar/data/models/home_card_model.dart';

List<HomeCardModel>homeCards=[
  HomeCardModel(icon: Icons.note_add, title: 'Notes', color: AppColors.kPrimaryColor,),
    HomeCardModel(icon: Icons.check_box, title: 'Tasks', color: AppColors.info,  ),

  HomeCardModel(icon: Icons.wallet, title: 'Finance', color: AppColors.financeYellow, ),

];