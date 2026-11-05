import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_cycle/core/routing/app_routes.dart';
import 'package:life_cycle/core/routing/routes.dart';
import 'package:life_cycle/core/theme/app_colors.dart';
import 'package:life_cycle/features/theme/data/theme_enum.dart';
import 'package:life_cycle/features/theme/logic/cubit/app_theme_cubit.dart';

class LifeCycle extends StatelessWidget {
  const LifeCycle({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: BlocProvider(
        create: (context) =>
            AppThemeCubit()..changeTheme(ThemeState.Initial),
        child: BlocBuilder<AppThemeCubit, AppThemeState>(
          builder: (context, state) {
            final ThemeMode themeMode;

            if (state is AppThemeLight) {
              themeMode = ThemeMode.light;
            } else if (state is AppThemeDark) {
              themeMode = ThemeMode.dark;
            } else {
              themeMode = ThemeMode.system;
            }

            return MaterialApp(
              debugShowCheckedModeBanner: false,
              onGenerateRoute: AppRoutes().generateRoute,
              initialRoute: Routes.splashScreen,

              themeMode: themeMode,

              theme: ThemeData.light().copyWith(
                scaffoldBackgroundColor: AppColors.whiteColor,
              ),

              darkTheme: ThemeData.dark().copyWith(
                scaffoldBackgroundColor:
                    AppColors.scaffoldBackground,
              ),
            );
          },
        ),
      ),
    );
  }
}