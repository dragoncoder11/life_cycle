import 'package:dio/dio.dart';
import 'package:life_cycle/core/helper/app_constants.dart';

class PrayerService {
  final Dio dio;

  PrayerService({required this.dio});
 Future<Map<String,dynamic>> getPrayerTimes({
    required String date,
    required double latitude,
    required double longitude,
  }) async {
    try {
      var response = await dio.get(
        '$prayersUrl$date',
        queryParameters: {
          'latitude': latitude,
          'longitude': longitude,
          'method': 5,
        },
      );
      var responseBody = response.data;
      if (responseBody['code'] != 200) {
        throw Exception('Failed to get prayer times');
      }
      return responseBody['data'];
    } on DioException catch (e) {
      throw Exception(e.toString()??'something went wrong');
    }
  }
}
