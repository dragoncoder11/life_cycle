part of 'prayer_settings_cubit.dart';

abstract class PrayerSettingsState {}

class PrayerSettingsInitial extends PrayerSettingsState {}

class PrayerSettingsUpdated extends PrayerSettingsState {
  final Map<String, bool> settings;

  PrayerSettingsUpdated({
    required this.settings,
  });
}