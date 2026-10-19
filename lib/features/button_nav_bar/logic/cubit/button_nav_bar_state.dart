part of 'button_nav_bar_cubit.dart';

@immutable
sealed class ButtonNavBarState {}

final class ButtonNavBarInitial extends ButtonNavBarState {}

final class ChangeIndex extends ButtonNavBarState {}
