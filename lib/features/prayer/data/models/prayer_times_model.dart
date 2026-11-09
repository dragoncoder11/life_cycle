class PrayerTimesModel {
  final String fajrTime;
  final String dhuhrTime;
  final String asrTime;
  final String maghribTime;
  final String ishaTime;
  final String date;
  final String timeZone;

  PrayerTimesModel({
    required this.fajrTime,
    required this.dhuhrTime,
    required this.asrTime,
    required this.maghribTime,
    required this.ishaTime,
    required this.date,
    required this.timeZone,
  });

  factory PrayerTimesModel.fromJson(Map<String, dynamic> json) {
    final timings = json['timings'] as Map<String, dynamic>;

    String formatTime(String value) {
      return value.split(' ').first;
    }

    return PrayerTimesModel(
      fajrTime: formatTime(timings['Fajr'].toString()),
      dhuhrTime: formatTime(timings['Dhuhr'].toString()),
      asrTime: formatTime(timings['Asr'].toString()),
      maghribTime: formatTime(timings['Maghrib'].toString()),
      ishaTime: formatTime(timings['Isha'].toString()),
      date: json['date']['gregorian']['date'].toString(),
      timeZone: json['meta']['timezone'].toString(),
    );
  }
}
