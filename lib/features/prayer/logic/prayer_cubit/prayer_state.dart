part of 'prayer_cubit.dart';

abstract class PrayerState {}

class PrayerInitial extends PrayerState {}

class PrayerLoading extends PrayerState {}

class PrayerFailure extends PrayerState {
  final String errMessage;

  PrayerFailure({required this.errMessage});
}

class PrayerLoaded extends PrayerState {
  final PrayerTimesModel prayerTimes;
  final String nextPrayer;
  final DateTime nextPrayerTime;

  Duration get remainingDuration {
    final difference = nextPrayerTime.difference(DateTime.now());

    return difference.isNegative ? Duration.zero : difference;
  }

  PrayerLoaded({
    required this.prayerTimes,
    required this.nextPrayer,
    required this.nextPrayerTime,
  });
}