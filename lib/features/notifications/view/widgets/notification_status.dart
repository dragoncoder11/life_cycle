import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationStatus {
  static const String _key = 'hasUnreadNotifications';

  static final ValueNotifier<bool> hasUnread =
      ValueNotifier<bool>(false);

  static late SharedPreferences _prefs;

  static Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();

    hasUnread.value = _prefs.getBool(_key) ?? false;
  }

  static Future<void> markUnread() async {
    hasUnread.value = true;
    await _prefs.setBool(_key, true);
  }

  static Future<void> markRead() async {
    hasUnread.value = false;
    await _prefs.setBool(_key, false);
  }
}