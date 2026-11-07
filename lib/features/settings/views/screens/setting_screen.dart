import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_cycle/core/helper/spacing.dart';
import 'package:life_cycle/core/theme/app_colors.dart';
import 'package:life_cycle/core/theme/status_bar_mode.dart';
import 'package:life_cycle/features/settings/views/widgets/setting_list_tile.dart';
import 'package:life_cycle/features/theme/data/theme_enum.dart';
import 'package:life_cycle/features/theme/logic/cubit/app_theme_cubit.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.read<AppThemeCubit>();
    final themeState = context.watch<AppThemeCubit>().state;
    final isDark =
        themeState is AppThemeDark ||
        (themeState is AppThemeSystem &&
            MediaQuery.platformBrightnessOf(context) == Brightness.dark);
    return StatusBarMode(
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(top: 8.h, left: 16.w, right: 16.w),
            child: Column(
              children: [
                verticalSpace(16),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Text(
                      'Settings',
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  ],
                ),
                verticalSpace(16),
                SettingListTile(
                  icon: Icons.bedtime,
                  title: 'Dark Theme',
                  subTitle: 'Switch to dark mode',
                  trailing: CupertinoSwitch(
                    value: isDark,
                    activeTrackColor: AppColors.kPrimaryColor,

                    onChanged: (status) {
                      themeCubit.changeTheme(
                        status ? ThemeState.Dark : ThemeState.Light,
                      );
                    },
                  ),
                ),
                verticalSpace(6),
                SettingListTile(
                  icon: Icons.notifications,
                  title: 'Notifications',
                ),
                verticalSpace(2),

                SettingListTile(icon: Icons.shield, title: 'App Info'),
                verticalSpace(2),

                SettingListTile(icon: Icons.info, title: 'About Life Cycle'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
