
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_cycle/core/routing/app_routes.dart';
import 'package:life_cycle/core/routing/routes.dart';

class LifeCycle extends StatelessWidget {
  const LifeCycle({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
      //  home:const SplashScreen(),
          onGenerateRoute: AppRoutes().generateRoute,
          initialRoute: Routes.splashScreen,

      ),
    );
  }
}
