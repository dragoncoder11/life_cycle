import 'package:shared_preferences/shared_preferences.dart';

abstract class CacheData {
  late SharedPreferences sharedPreferences;

  Future<void> cacheInitialization() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<bool> setData(String key, dynamic value) async {
    if (value is int) {
      return await sharedPreferences.setInt(key, value);
    } else if (value is double) {
      return await sharedPreferences.setDouble(key, value);
    } else if (value is bool) {
      return await sharedPreferences.setBool(key, value);
    } else if (value is List<String>) {
      return await sharedPreferences.setStringList(key, value);
    } else if (value is String) {
      return await sharedPreferences.setString(key, value);
    } else {
      throw Exception("Invalid data type");
    }
  }

  dynamic getData(String key) {
    return sharedPreferences.get(key);
  }

  Future<bool> deleteData(String key) async {
    return await sharedPreferences.remove(key);
  }
}

class Cache extends CacheData {
  Cache();
}
