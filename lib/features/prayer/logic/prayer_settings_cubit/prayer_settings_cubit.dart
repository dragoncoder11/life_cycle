import 'package:bloc/bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:life_cycle/core/helper/app_constants.dart';

part 'prayer_settings_state.dart';

class PrayerSettingsCubit extends Cubit<PrayerSettingsState> {
  PrayerSettingsCubit() : super(PrayerSettingsInitial()) {
    loadSettings();
  }

  late final Box<bool> _settingsBox;

  final Map<String, bool> _defaultSettings = {
    'fajrEnabled': true,
    'dhuhrEnabled': true,
    'asrEnabled': true,
    'maghribEnabled': true,
    'ishaEnabled': true,
  };

  Map<String, bool> settings = {};

  void loadSettings() {
    _settingsBox = Hive.box<bool>(kPrayerSettingsBox);

    settings = {
      for (final entry in _defaultSettings.entries)
        entry.key: _settingsBox.get(
          entry.key,
          defaultValue: entry.value,
        )!,
    };

    emit(
      PrayerSettingsUpdated(
        settings: Map.from(settings),
      ),
    );
  }

  bool isEnabled(String key) {
    return settings[key] ?? true;
  }

  Future<void> togglePrayer(String key, bool value) async {
    if (!_defaultSettings.containsKey(key)) return;

    await _settingsBox.put(key, value);

    settings[key] = value;

    emit(
      PrayerSettingsUpdated(
        settings: Map.from(settings),
      ),
    );
  }
}