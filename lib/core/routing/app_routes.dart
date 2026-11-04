import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:life_cycle/core/routing/routes.dart';

import 'package:life_cycle/features/button_nav_bar/logic/cubit/button_nav_bar_cubit.dart';
import 'package:life_cycle/features/button_nav_bar/view/screens/button_nav_bar_screen.dart';

import 'package:life_cycle/features/finance/logic/cubit/finance_cubit.dart';
import 'package:life_cycle/features/finance/logic/cubit/transaction_categories_cubit.dart';
import 'package:life_cycle/features/finance/view/screens/finance_screen.dart';

import 'package:life_cycle/features/home/view/screens/home_screen.dart';

import 'package:life_cycle/features/notes/logic/add_note_cubit/add_note_cubit.dart';
import 'package:life_cycle/features/notes/logic/get_notes/notes_cubit.dart';
import 'package:life_cycle/features/notes/view/screens/edit_note_screen.dart';
import 'package:life_cycle/features/notes/view/screens/note_screen.dart';

import 'package:life_cycle/features/notifications/view/screens/notifications_screen.dart';

import 'package:life_cycle/features/onBoarding/logic/cubit/on_boarding_cubit.dart';
import 'package:life_cycle/features/onBoarding/view/screens/onboarding_screen.dart';
import 'package:life_cycle/features/onBoarding/view/widgets/app_start_screen.dart';
import 'package:life_cycle/features/settings/views/screens/setting_screen.dart';

import 'package:life_cycle/features/tasks/logic/get_tasks/tasks_cubit.dart';
import 'package:life_cycle/features/tasks/view/screens/edit_task_screen.dart';
import 'package:life_cycle/features/tasks/view/screens/task_screen.dart';

import 'package:life_cycle/splash_screen.dart';

class CustomPageRoute extends MaterialPageRoute {
  CustomPageRoute({
    required super.builder,
    super.settings,
  });

  @override
  Duration get transitionDuration =>
      const Duration(milliseconds: 750);
}

class AppRoutes {
  Route? generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.buttonNavBarScreen:
        return CustomPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => ButtonNavBarCubit(),
            child: const ButtonNavBarScreen(),
          ),
        );

      case Routes.financeScreen:
        return CustomPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) => TransactionCategoriesCubit(),
              ),
              BlocProvider(
                create: (_) => FinanceCubit(),
              ),
            ],
            child: const FinanceScreen(),
          ),
        );

      case Routes.homeScreen:
        return CustomPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => ButtonNavBarCubit(),
            child: const HomeScreen(),
          ),
        );

      case Routes.noteScreen:
        return CustomPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => AddNoteCubit()),
              BlocProvider(
                create: (_) => NotesCubit()..fetchNotes(),
              ),
            ],
            child: const NoteScreen(),
          ),
        );

      case Routes.taskScreen:
        return CustomPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => TasksCubit(),
            child: const TaskScreen(),
          ),
        );

      case Routes.onboardingScreen:
        return CustomPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => OnBoardingCubit(),
            child: const OnBoardingScreen(),
          ),
        );

      case Routes.splashScreen:
        return CustomPageRoute(
          builder: (_) => const SplashScreen(),
        );
        case Routes.settingScreen:
        return CustomPageRoute(
          builder: (_) => const SettingScreen(),
        );

      case Routes.editNoteScreen:
        final args = routeSettings.arguments as Map<String, dynamic>;

        return CustomPageRoute(
          settings: routeSettings,
          builder: (_) => BlocProvider.value(
            value: args['cubit'] as NotesCubit,
            child: const EditNoteScreen(),
          ),
        );

      case Routes.editTaskScreen:
        final args = routeSettings.arguments as Map<String, dynamic>;return CustomPageRoute(
          settings: routeSettings,
          builder: (_) => BlocProvider.value(
            value: args['cubit'] as TasksCubit,
            child: const EditTaskScreen(),
          ),
        );

      case Routes.notificationsScreen:
        return CustomPageRoute(
          builder: (_) => const NotificationsScreen(),
          
        );
         case Routes.appstartScreen:
        return CustomPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => OnBoardingCubit()..checkOnBoarding(),),
              BlocProvider(
                create: (_) => ButtonNavBarCubit(),
              ),
            ],
            child: const AppStartScreen(),
          ),
        );

      default:
        return null;
    }
  }
}