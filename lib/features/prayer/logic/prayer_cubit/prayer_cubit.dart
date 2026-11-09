import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:life_cycle/features/prayer/data/models/prayer_times_model.dart';
import 'package:life_cycle/features/prayer/data/repos/prayer_repo_implementation.dart';
import 'package:life_cycle/features/prayer/data/services/location_service.dart';
import 'package:life_cycle/features/prayer/data/services/prayer_service.dart';

part 'prayer_state.dart';

class PrayerCubit extends Cubit<PrayerState> {
  PrayerCubit() : super(PrayerInitial()) {
    prayerRepoImplementation = PrayerRepoImplementation(
      prayerService: PrayerService(dio: Dio()),
    );
  }

  final LocationService locationService = LocationService();

  late final PrayerRepoImplementation prayerRepoImplementation;

  Timer? _timer;

  Future<void> getPrayerTimes() async {
    emit(PrayerLoading());

    try {
      final now = DateTime.now();
      final position = await locationService.getCurrentLocation();

      final date =
          '${now.day.toString().padLeft(2, '0')}-'
          '${now.month.toString().padLeft(2, '0')}-'
          '${now.year}';

      final result = await prayerRepoImplementation.getPrayerTimes(
        date: date,
        latitude: position.latitude,
        longitude: position.longitude,
      );

      result.fold(
        (failure) {
          emit(PrayerFailure(errMessage: failure));
        },
        (prayerTimes) {
          _updateNextPrayer(prayerTimes);
          _startTimer(prayerTimes);
        },
      );
    } catch (e) {
      emit(PrayerFailure(errMessage: e.toString()));
    }
  }

  void _startTimer(PrayerTimesModel prayerTimes) {
    _timer?.cancel();

    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        if (!isClosed) {
          _updateNextPrayer(prayerTimes);
        }
      },
    );
  }

  void _updateNextPrayer(PrayerTimesModel prayerTimes) {
    final now = DateTime.now();

    final prayers = [
      {'name': 'Fajr', 'time': prayerTimes.fajrTime},
      {'name': 'Dhuhr', 'time': prayerTimes.dhuhrTime},
      {'name': 'Asr', 'time': prayerTimes.asrTime},
      {'name': 'Maghrib', 'time': prayerTimes.maghribTime},
      {'name': 'Isha', 'time': prayerTimes.ishaTime},
    ];

    DateTime? nextPrayerDate;
    String? nextPrayerName;
    String? nextPrayerTime;

    for (final prayer in prayers) {
      final timeParts = prayer['time']!.split(':');

      final prayerDate = DateTime(
        now.year,
        now.month,
        now.day,
        int.parse(timeParts[0]),
        int.parse(timeParts[1]),
      );

      if (prayerDate.isAfter(now)) {
        nextPrayerDate = prayerDate;
        nextPrayerName = prayer['name'];
        nextPrayerTime = prayer['time'];
        break;
      }
    }

    // لو كل صلوات اليوم عدت، الصلاة القادمة هي فجر الغد.
    if (nextPrayerDate == null) {
      final fajrParts = prayerTimes.fajrTime.split(':');

      nextPrayerDate = DateTime(
        now.year,
        now.month,
        now.day + 1,
        int.parse(fajrParts[0]),
        int.parse(fajrParts[1]),
      );

      nextPrayerName = 'Fajr';
      nextPrayerTime = prayerTimes.fajrTime;
    }

    emit(
      PrayerSuccess(
        prayerTimes: prayerTimes,
        nextPrayerName: nextPrayerName!,
        nextPrayerTime: nextPrayerTime!,
        remainingDuration: nextPrayerDate.difference(now),
      ),
    );
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}