
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  NotificationService._();

  static final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  static bool _initialized = false;

  // Initialize notifications
  static Future<void> initialize() async {
    if (_initialized) return;

    try {
      debugPrint('NOTIFICATION: Initialization started');

      tz_data.initializeTimeZones();

      final timezoneInfo = await FlutterTimezone.getLocalTimezone();

      tz.setLocalLocation(
        tz.getLocation(timezoneInfo.identifier),
      );

      const androidSettings = AndroidInitializationSettings(
        '@mipmap/ic_launcher',
      );

      const initializationSettings = InitializationSettings(
        android: androidSettings,
      );

      await _notifications.initialize(
        settings: initializationSettings,
      );

      final androidPlugin = _notifications
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();

      final notificationPermission =
          await androidPlugin?.requestNotificationsPermission();

      debugPrint(
        'NOTIFICATION: Permission result = $notificationPermission',
      );

      await androidPlugin?.requestExactAlarmsPermission();

      _initialized = true;

      debugPrint('NOTIFICATION: Initialization completed');
    } catch (e, stackTrace) {
      debugPrint('NOTIFICATION INITIALIZATION ERROR: $e');
      debugPrintStack(stackTrace: stackTrace);
      rethrow;
    }
  }

  // Schedule a task notification
  static Future<void> scheduleTaskNotification({
    required int id,
    required String title,
    required DateTime scheduledDate,
  }) async {
    if (!_initialized) {
      await initialize();
    }

    if (!scheduledDate.isAfter(DateTime.now())) {
      debugPrint(
        'NOTIFICATION: Skipped because the date is in the past',
      );
      return;
    }

    try {
      final scheduledTime = tz.TZDateTime.from(
        scheduledDate,
        tz.local,
      );

      await _notifications.zonedSchedule(
        id: id,
        title: 'Task Reminder 🔔',
        body: 'It is time for: $title',
        scheduledDate: scheduledTime,
        notificationDetails: const NotificationDetails(
          android: AndroidNotificationDetails(
            'task_reminders',
            'Task Reminders',
            channelDescription: 'Reminders for your scheduled tasks',
            importance: Importance.max,
            priority: Priority.high,
            playSound: true,
          ),
        ),
        androidScheduleMode:
            AndroidScheduleMode.exactAllowWhileIdle,
      );

      debugPrint('NOTIFICATION: Scheduled successfully');
      debugPrint('NOTIFICATION: ID = $id');
      debugPrint('NOTIFICATION: Title = $title');
      debugPrint('NOTIFICATION: Time = $scheduledTime');
    } catch (e, stackTrace) {
      debugPrint('NOTIFICATION SCHEDULING ERROR: $e');
      debugPrintStack(stackTrace: stackTrace);
      rethrow;
    }
  }

  // Show an immediate test notification
  static Future<void> showTestNotification() async {
    if (!_initialized) {
      await initialize();
    }

    await _notifications.show(
      id: 999999,
      title: 'Test Notification 🔔',
      body: 'Notifications are working correctly!',
      notificationDetails: const NotificationDetails(
        android: AndroidNotificationDetails(
          'task_reminders',
          'Task Reminders',
          channelDescription: 'Reminders for your scheduled tasks',
          importance: Importance.max,
          priority: Priority.high,
          playSound: true,
        ),
      ),
    );
  }

  // Cancel a scheduled notification
  static Future<void> cancelTaskNotification(int id) async {
    await _notifications.cancel(id: id);
    debugPrint('NOTIFICATION: Cancelled ID = $id');
  }
}
