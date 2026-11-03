import 'dart:async';

import 'package:alarm/alarm.dart';
import 'package:flutter/foundation.dart';

class TaskAlarmService {
  TaskAlarmService._();

  // Store timers for scheduled alarms
  static final Map<int, Timer> _alarmTimers = {};

  static Future<void> scheduleTaskAlarm({
    required int id,
    required String title,
    required DateTime scheduledDate,
  }) async {
    if (!scheduledDate.isAfter(DateTime.now())) {
      debugPrint('TASK ALARM: The selected time is in the past');
      return;
    }

    // Alarm IDs cannot be zero or negative.
    final int alarmId = id + 1;

    // Cancel any previous timer for this alarm.
    _alarmTimers[alarmId]?.cancel();
    _alarmTimers.remove(alarmId);

    final alarmSettings = AlarmSettings(
      id: alarmId,
      dateTime: scheduledDate,
      assetAudioPath: 'assets/audio/alarm.mp3',
      loopAudio: true,
      vibrate: true,
      warningNotificationOnKill: true,
      androidFullScreenIntent: true,
      notificationSettings: NotificationSettings(
        title: 'حان وقت المهمة 🔔',
        body: title,
        stopButton: 'إيقاف المنبه',
      ),
    );

    await Alarm.set(alarmSettings: alarmSettings);

    debugPrint('TASK ALARM: Scheduled successfully');
    debugPrint('TASK ALARM: ID = $alarmId');
    debugPrint('TASK ALARM: Time = $scheduledDate');

    // Calculate the time until the alarm rings, plus 2 minutes.
    final durationUntilStop = scheduledDate
        .difference(DateTime.now()) +
        const Duration(minutes: 2);

    // Automatically stop the alarm after 2 minutes of ringing.
    _alarmTimers[alarmId] = Timer(
      durationUntilStop,
      () async {
        try {
          await Alarm.stop(alarmId);

          debugPrint('TASK ALARM: Automatically stopped after 2 minutes');
        } catch (e) {
          debugPrint('TASK ALARM STOP ERROR: $e');
        } finally {
          _alarmTimers.remove(alarmId);
        }
      },
    );
  }

  // Stop alarm manually
  static Future<void> stopTaskAlarm(int taskId) async {
    final alarmId = taskId + 1;

    _alarmTimers[alarmId]?.cancel();
    _alarmTimers.remove(alarmId);

    await Alarm.stop(alarmId);

    debugPrint('TASK ALARM: Stopped for task $taskId');
  }

  // Cancel alarm when deleting a task
  static Future<void> cancelTaskAlarm(int taskId) async {
    final alarmId = taskId + 1;

    _alarmTimers[alarmId]?.cancel();
    _alarmTimers.remove(alarmId);

    await Alarm.stop(alarmId);

    debugPrint('TASK ALARM: Cancelled for task $taskId');
  }
}