part of 'prayer_cubit.dart';

sealed class PrayerState {}

final class PrayerInitial extends PrayerState {}

final class PrayerLoading extends PrayerState {}

final class PrayerSuccess extends PrayerState {
  final PrayerTimesModel prayerTimes;
  final String nextPrayerName;
  final String nextPrayerTime;
  final Duration remainingDuration;

  PrayerSuccess({
    required this.prayerTimes,
    required this.nextPrayerName,
    required this.nextPrayerTime,
    required this.remainingDuration,
  });
}

final class PrayerFailure extends PrayerState {
  final String errMessage;

  PrayerFailure({required this.errMessage});
}