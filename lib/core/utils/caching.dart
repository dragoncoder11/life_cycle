import 'package:shared_preferences/shared_preferences.dart';

class Cache {
  static final Cache instance = Cache._internal();

  late SharedPreferences sharedPreferences;

  Cache._internal();

  Future<void> cacheInitialization() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<bool> setData(String key, dynamic value) async {
    if (value is int) {
      return sharedPreferences.setInt(key, value);
    } else if (value is double) {
      return sharedPreferences.setDouble(key, value);
    } else if (value is bool) {
      return sharedPreferences.setBool(key, value);
    } else if (value is List<String>) {
      return sharedPreferences.setStringList(key, value);
    } else if (value is String) {
      return sharedPreferences.setString(key, value);
    } else {
      throw Exception('Invalid data type');
    }
  }

  dynamic getData(String key) {
    return sharedPreferences.get(key);
  }

  Future<bool> deleteData(String key) async {
    return sharedPreferences.remove(key);
  }
}