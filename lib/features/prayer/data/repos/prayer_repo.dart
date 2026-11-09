import 'package:life_cycle/features/prayer/data/models/prayer_times_model.dart';
import 'package:dartz/dartz.dart';
abstract class PrayerRepo {
  Future<Either<String ,PrayerTimesModel>> getPrayerTimes({
    required String date,
    required double latitude,
    required double longitude,
  });
}
