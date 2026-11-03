import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_cycle/features/button_nav_bar/view/screens/button_nav_bar_screen.dart';
import 'package:life_cycle/features/onBoarding/logic/cubit/on_boarding_cubit.dart';
import 'package:life_cycle/features/onBoarding/view/screens/onboarding_screen.dart';

class AppStartScreen extends StatelessWidget {
  const AppStartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnBoardingCubit, OnBoardingState>(
      builder: (context, state) {
        final cubit = context.read<OnBoardingCubit>();
    
        return cubit.isCompleted
            ? const ButtonNavBarScreen()
            : const OnBoardingScreen();
      },
    );
  }
}