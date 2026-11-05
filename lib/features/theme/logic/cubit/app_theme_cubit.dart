import 'package:bloc/bloc.dart';
import 'package:life_cycle/core/utils/caching.dart';
import 'package:life_cycle/features/theme/data/theme_enum.dart';
import 'package:meta/meta.dart';

part 'app_theme_state.dart';

class AppThemeCubit extends Cubit<AppThemeState> {
  AppThemeCubit() : super(AppThemeSystem());

  void changeTheme(ThemeState state) {
    switch (state) {
      case ThemeState.Initial:
        final savedTheme = Cache.instance.getData('theme');

        if (savedTheme == 'l') {
          emit(AppThemeLight());
        } else if (savedTheme == 'd') {
          emit(AppThemeDark());
        } else {
          emit(AppThemeSystem());
        }
        break;

      case ThemeState.Light:
        Cache.instance.setData('theme', 'l');
        emit(AppThemeLight());
        break;

      case ThemeState.Dark:
        Cache.instance.setData('theme', 'd');
        emit(AppThemeDark());
        break;

      case ThemeState.System:
        Cache.instance.setData('theme', 's');
        emit(AppThemeSystem());
        break;
    }
  }
}