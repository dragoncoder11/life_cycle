import 'package:dartz/dartz.dart';
import 'package:life_cycle/features/prayer/data/models/prayer_times_model.dart';
import 'package:life_cycle/features/prayer/data/repos/prayer_repo.dart';
import 'package:life_cycle/features/prayer/data/services/prayer_service.dart';

class PrayerRepoImplementation implements PrayerRepo {
  final PrayerService prayerService;

  PrayerRepoImplementation({
    required this.prayerService,
  });

  @override
  Future<Either<String, PrayerTimesModel>> getPrayerTimes({
    required String date,
    required double latitude,
    required double longitude,
  }) async {
    try {
      final data = await prayerService.getPrayerTimes(
        date: date,
        latitude: latitude,
        longitude: longitude,
      );

      final prayerTimes = PrayerTimesModel.fromJson(data);

      return right(prayerTimes);
    } catch (e) {
      return left(e.toString());
    }
  }
}