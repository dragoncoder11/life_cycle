import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_cycle/core/routing/routes.dart';
import 'package:life_cycle/features/button_nav_bar/logic/cubit/button_nav_bar_cubit.dart';
import 'package:life_cycle/features/button_nav_bar/view/screens/button_nav_bar_screen.dart';
import 'package:life_cycle/features/finance/view/screens/finance_screen.dart';
import 'package:life_cycle/features/home/view/screens/home_screen.dart';
import 'package:life_cycle/features/notes/view/screens/edit_note_screen.dart';
import 'package:life_cycle/features/notes/view/screens/note_screen.dart';
import 'package:life_cycle/features/onBoarding/logic/cubit/on_boarding_cubit.dart';
import 'package:life_cycle/features/onBoarding/view/screens/onboarding_screen.dart';
import 'package:life_cycle/features/tasks/view/screens/task_screen.dart';
import 'package:life_cycle/splash_screen.dart';

class CustomPageRoute extends MaterialPageRoute {
  CustomPageRoute({required super.builder});

  @override
  Duration get transitionDuration => const Duration(milliseconds: 750);
}

class AppRoutes {
  Route? generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.buttonNavBarScreen:
        return CustomPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => ButtonNavBarCubit(),
            child: const ButtonNavBarScreen(),
          ),
        );
      case Routes.financeScreen:
        return CustomPageRoute(builder: (_) => const FinanceScreen());
      case Routes.homeScreen:
        return CustomPageRoute(builder: (_) => const HomeScreen());
      case Routes.noteScreen:
        return CustomPageRoute(builder: (_) => const NoteScreen());
      case Routes.taskScreen:
        return CustomPageRoute(builder: (_) => const TaskScreen());
      case Routes.onboardingScreen:
        return CustomPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => OnBoardingCubit(),
            child: const OnBoardingScreen(),
          ),
        );
      case Routes.splashScreen:
        return CustomPageRoute(builder: (_) => const SplashScreen());
      case Routes.editNoteScreen:
        return CustomPageRoute(builder: (_) => const EditNoteScreen());
      default:
        return null;
    }
  }
}
