import 'package:alarm/alarm.dart';
import 'package:alarm/model/alarm_settings.dart';
import 'package:alarm/model/notification_settings.dart';
import 'package:life_cycle/features/prayer/data/models/prayer_times_model.dart';

class AdhanService {
  static const Map<String, int> prayerIds = {
    'fajr': 1,
    'dhuhr': 2,
    'asr': 3,
    'maghrib': 4,
    'isha': 5,
  };

  static const String normalAdhan = 'assets/audio/adhan.mp3';
  static const String fajrAdhan = 'assets/audio/fajr_adhan.mp3';

  // إلغاء جميع مواعيد الأذان المحجوزة.
  Future<void> cancelAllAdhans() async {
    for (int id = 1; id <= 10; id++) {
      await Alarm.stop(id);
    }
  }

  // إلغاء أذان صلاة معينة لليوم وبكرة.
  Future<void> cancelAdhan(String prayerName) async {
    final id = prayerIds[prayerName.toLowerCase()];

    if (id == null) return;

    await Alarm.stop(id);
    await Alarm.stop(id + 5);
  }

  // جدولة أذان واحد.
  Future<void> _scheduleAdhan({
    required int id,
    required String prayerName,
    required DateTime prayerTime,
  }) async {
    if (!prayerTime.isAfter(DateTime.now())) return;

    final audioPath =
        prayerName == 'fajr' ? fajrAdhan : normalAdhan;

    await Alarm.set(
      alarmSettings: AlarmSettings(
        id: id,
        dateTime: prayerTime,
        assetAudioPath: audioPath,
        loopAudio: false,
        vibrate: false,
        warningNotificationOnKill: false,
        androidFullScreenIntent: false,
        notificationSettings: NotificationSettings(
          title: 'حان الآن موعد الصلاة',
          body: 'حان موعد صلاة $prayerName',
          stopButton: 'إيقاف الأذان',
          icon:'notification_small_logo'
        ),
      ),
    );
  }

  // جدولة صلوات يوم واحد.
  Future<void> _scheduleDay({
    required PrayerTimesModel prayerTimes,
    required DateTime date,
    required Map<String, bool> settings,
    required int idOffset,
  }) async {
    final prayers = {
      'fajr': prayerTimes.fajrTime,
      'dhuhr': prayerTimes.dhuhrTime,
      'asr': prayerTimes.asrTime,
      'maghrib': prayerTimes.maghribTime,
      'isha': prayerTimes.ishaTime,
    };

    for (final entry in prayers.entries) {
      final prayerName = entry.key;

      final enabled =
          settings['${prayerName}Enabled'] ?? true;

      if (!enabled) continue;

      final timeParts = entry.value.split(':');

      final prayerDate = DateTime(
        date.year,
        date.month,
        date.day,
        int.parse(timeParts[0]),
        int.parse(timeParts[1]),
      );

      final id = prayerIds[prayerName]! + idOffset;

      await _scheduleAdhan(
        id: id,
        prayerName: prayerName,
        prayerTime: prayerDate,
      );
    }
  }

  // جدولة اليوم وبكرة.
  Future<void> scheduleAllPrayers({
    required PrayerTimesModel todayPrayerTimes,
    required PrayerTimesModel tomorrowPrayerTimes,
    required Map<String, bool> settings,
  }) async {
    final now = DateTime.now();

    final tomorrow = DateTime(
      now.year,
      now.month,
      now.day + 1,
    );

    await cancelAllAdhans();

    await _scheduleDay(
      prayerTimes: todayPrayerTimes,
      date: now,
      settings: settings,
      idOffset: 0,
    );

    await _scheduleDay(
      prayerTimes: tomorrowPrayerTimes,
      date: tomorrow,
      settings: settings,
      idOffset: 5,
    );
  }

  // استخدامها لو فشل طلب مواقيت بكرة.
  Future<void> scheduleTodayOnly({
    required PrayerTimesModel todayPrayerTimes,
    required Map<String, bool> settings,
  }) async {
    await cancelAllAdhans();

    await _scheduleDay(
      prayerTimes: todayPrayerTimes,
      date: DateTime.now(),
      settings: settings,
      idOffset: 0,
    );
  }

  // اختبار تشغيل الأذان بعد دقيقة واحدة.
  Future<void> testAdhan() async {
    const int testAlarmId = 99;

    // إلغاء اختبار سابق إن وجد.
    await Alarm.stop(testAlarmId);

    // تحديد موعد الاختبار بعد دقيقة.
    final testTime = DateTime.now().add(
      const Duration(minutes: 1),
    );await Alarm.set(
      alarmSettings: AlarmSettings(
        id: testAlarmId,
        dateTime: testTime,
        assetAudioPath: normalAdhan,
        loopAudio: false,
        vibrate: false,
        warningNotificationOnKill: false,
        androidFullScreenIntent: false,
        notificationSettings: NotificationSettings(
          title: 'اختبار الأذان',
          body: 'هذا اختبار لتشغيل الأذان',
          stopButton: 'إيقاف الأذان',
          icon: 'notification_small_logo'
        ),
      ),
    );
  }
}