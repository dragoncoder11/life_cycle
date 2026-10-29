
import 'package:alarm/alarm.dart';
import 'package:flutter/foundation.dart';

class TaskAlarmService {
  TaskAlarmService._();

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
  }

  static Future<void> stopTaskAlarm(int taskId) async {
    await Alarm.stop(taskId + 1);
    debugPrint('TASK ALARM: Stopped for task $taskId');
  }

  static Future<void> cancelTaskAlarm(int taskId) async {
    await Alarm.stop(taskId + 1);
    debugPrint('TASK ALARM: Cancelled for task $taskId');
  }
}
