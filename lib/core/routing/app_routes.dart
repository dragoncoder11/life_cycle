import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_cycle/core/routing/routes.dart';
import 'package:life_cycle/features/button_nav_bar/logic/cubit/button_nav_bar_cubit.dart';
import 'package:life_cycle/features/button_nav_bar/view/screens/button_nav_bar_screen.dart';
import 'package:life_cycle/features/finance/logic/cubit/transaction_categories_cubit.dart';
import 'package:life_cycle/features/finance/view/screens/add_balance_screen.dart';
import 'package:life_cycle/features/finance/view/screens/add_transaction_screen.dart';
import 'package:life_cycle/features/finance/view/screens/finance_screen.dart';
import 'package:life_cycle/features/home/view/screens/home_screen.dart';
import 'package:life_cycle/features/notes/logic/add_note_cubit/add_note_cubit.dart';
import 'package:life_cycle/features/notes/view/screens/edit_note_screen.dart';
import 'package:life_cycle/features/notes/view/screens/note_screen.dart';
import 'package:life_cycle/features/notifications/view/screens/notifications_screen.dart';
import 'package:life_cycle/features/onBoarding/logic/cubit/on_boarding_cubit.dart';
import 'package:life_cycle/features/onBoarding/view/screens/onboarding_screen.dart';
import 'package:life_cycle/features/tasks/logic/cubit/tasks_cubit.dart';
import 'package:life_cycle/features/tasks/view/screens/edit_task_screen.dart';
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
        return CustomPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => ButtonNavBarCubit(),
            child: const HomeScreen(),
          ),
        );
      case Routes.noteScreen:
        return CustomPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => AddNoteCubit(),
            child: const NoteScreen(),
          ),
        );
      case Routes.taskScreen:
        return CustomPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => TasksCubit(),
            child: const TaskScreen(),
          ),
        );
      case Routes.onboardingScreen:
        return CustomPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => OnBoardingCubit(),
            child: const OnBoardingScreen(),
          ),
        );
      case Routes.addBalanceScreen:
        return CustomPageRoute(builder: (_) => const AddBalanceScreen());
      case Routes.splashScreen:
        return CustomPageRoute(builder: (_) => const SplashScreen());
      case Routes.editNoteScreen:
        return CustomPageRoute(builder: (_) => const EditNoteScreen());
      case Routes.editTaskScreen:
        return CustomPageRoute(builder: (_) => const EditTaskScreen());
      case Routes.notificationsScreen:
        return CustomPageRoute(builder: (_) => const NotificationsScreen());
      case Routes.addTransactionScreen:
        return CustomPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => TransactionCategoriesCubit(),
            child: const AddTransactionScreen(),
          ),
        );
      default:
        return null;
    }
  }
}
