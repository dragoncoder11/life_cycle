import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:life_cycle/core/helper/app_constants.dart';
import 'package:life_cycle/features/prayer/data/models/prayer_times_model.dart';
import 'package:life_cycle/features/prayer/data/repos/prayer_repo_implementation.dart';
import 'package:life_cycle/features/prayer/data/services/location_service.dart';
import 'package:life_cycle/features/prayer/data/services/prayer_service.dart';
import 'package:life_cycle/features/prayer/data/services/adhan_service.dart';

part 'prayer_state.dart';

class PrayerCubit extends Cubit<PrayerState> {
  PrayerCubit() : super(PrayerInitial()) {
    prayerRepoImplementation = PrayerRepoImplementation(
      prayerService: PrayerService(dio: Dio()),
    );
  }

  final LocationService locationService = LocationService();
  final AdhanService adhanService = AdhanService();

  late final PrayerRepoImplementation prayerRepoImplementation;

  Timer? _timer;

  PrayerTimesModel? _currentPrayerTimes;
  PrayerTimesModel? _tomorrowPrayerTimes;

  double? _latitude;
  double? _longitude;

  // تحويل التاريخ إلى الصيغة المطلوبة من API.
  String _formatApiDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}-'
        '${date.month.toString().padLeft(2, '0')}-'
        '${date.year}';
  }

  // جلب مواقيت الصلاة لليوم.
  Future<void> getPrayerTimes() async {
    emit(PrayerLoading());

    try {
      final position = await locationService.getCurrentLocation();

      _latitude = position.latitude;
      _longitude = position.longitude;

      final now = DateTime.now();

      final result = await prayerRepoImplementation.getPrayerTimes(
        date: _formatApiDate(now),
        latitude: _latitude!,
        longitude: _longitude!,
      );

      await result.fold<Future<void>>(
        (failure) async {
          if (!isClosed) {
            emit(PrayerFailure(errMessage: failure));
          }
        },
        (prayerTimes) async {
          _currentPrayerTimes = prayerTimes;

          await refreshAdhanSchedule();

          if (isClosed) return;

          _updateNextPrayer(prayerTimes);
          _startTimer(prayerTimes);
        },
      );
    } catch (e) {
      if (!isClosed) {
        emit(PrayerFailure(errMessage: e.toString()));
      }
    }
  }

  // إعدادات الأذان المحفوظة في Hive.
  Map<String, bool> _getPrayerSettings() {
    final settingsBox = Hive.box<bool>(kPrayerSettingsBox);

    return {
      'fajrEnabled': settingsBox.get(
        'fajrEnabled',
        defaultValue: true,
      )!,
      'dhuhrEnabled': settingsBox.get(
        'dhuhrEnabled',
        defaultValue: true,
      )!,
      'asrEnabled': settingsBox.get(
        'asrEnabled',
        defaultValue: true,
      )!,
      'maghribEnabled': settingsBox.get(
        'maghribEnabled',
        defaultValue: true,
      )!,
      'ishaEnabled': settingsBox.get(
        'ishaEnabled',
        defaultValue: true,
      )!,
    };
  }

  // جلب مواقيت بكرة وإعادة جدولة الأذان.
  Future<void> refreshAdhanSchedule() async {
    if (_currentPrayerTimes == null ||
        _latitude == null ||
        _longitude == null ||
        isClosed) {
      return;
    }

    try {
      final tomorrow = DateTime.now().add(
        const Duration(days: 1),
      );

      final result = await prayerRepoImplementation.getPrayerTimes(
        date: _formatApiDate(tomorrow),
        latitude: _latitude!,
        longitude: _longitude!,
      );

      await result.fold<Future<void>>(
        (failure) async {
          _tomorrowPrayerTimes = null;

          await adhanService.scheduleTodayOnly(
            todayPrayerTimes: _currentPrayerTimes!,
            settings: _getPrayerSettings(),
          );
        },
        (tomorrowPrayerTimes) async {
          _tomorrowPrayerTimes = tomorrowPrayerTimes;await adhanService.scheduleAllPrayers(
            todayPrayerTimes: _currentPrayerTimes!,
            tomorrowPrayerTimes: _tomorrowPrayerTimes!,
            settings: _getPrayerSettings(),
          );
        },
      );
    } catch (e) {
      // في حالة فشل جلب مواقيت بكرة، نكتفي بجدولة اليوم.
      try {
        await adhanService.scheduleTodayOnly(
          todayPrayerTimes: _currentPrayerTimes!,
          settings: _getPrayerSettings(),
        );
      } catch (_) {}
    }
  }

  // تحديد الصلاة القادمة.
  void _updateNextPrayer(PrayerTimesModel prayerTimes) {
    final now = DateTime.now();

    final prayers = {
      'Fajr': prayerTimes.fajrTime,
      'Dhuhr': prayerTimes.dhuhrTime,
      'Asr': prayerTimes.asrTime,
      'Maghrib': prayerTimes.maghribTime,
      'Isha': prayerTimes.ishaTime,
    };

    String? nextPrayer;
    DateTime? nextPrayerTime;

    for (final entry in prayers.entries) {
      final parts = entry.value.split(':');

      final prayerDate = DateTime(
        now.year,
        now.month,
        now.day,
        int.parse(parts[0]),
        int.parse(parts[1]),
      );

      if (prayerDate.isAfter(now)) {
        nextPrayer = entry.key;
        nextPrayerTime = prayerDate;
        break;
      }
    }

    if (nextPrayer == null) {
      nextPrayer = 'Fajr';

      final parts = prayerTimes.fajrTime.split(':');

      nextPrayerTime = DateTime(
        now.year,
        now.month,
        now.day + 1,
        int.parse(parts[0]),
        int.parse(parts[1]),
      );
    }

    if (!isClosed) {
      emit(
        PrayerLoaded(
          prayerTimes: prayerTimes,
          nextPrayer: nextPrayer,
          nextPrayerTime: nextPrayerTime!,
        ),
      );
    }
  }

  // تحديث الصلاة القادمة كل دقيقة.
  void _startTimer(PrayerTimesModel prayerTimes) {
    _timer?.cancel();

    _timer = Timer.periodic(
      const Duration(minutes: 1),
      (_) {
        if (!isClosed) {
          _updateNextPrayer(prayerTimes);
        }
      },
    );
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}