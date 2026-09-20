import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences _sharedPreferences;

  /// Initialize SharedPreferences before using it (called in main.dart)
  static Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  /// Save any type of data (String, int, bool, double)
  static Future<bool> setData({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) return await _sharedPreferences.setString(key, value);
    if (value is int) return await _sharedPreferences.setInt(key, value);
    if (value is bool) return await _sharedPreferences.setBool(key, value);
    if (value is double) return await _sharedPreferences.setDouble(key, value);
    return false;
  }

  /// Get data dynamically
  static dynamic getData({required String key}) {
    return _sharedPreferences.get(key);
  }

  /// Customized Getters to ensure Type Safety
  static String getString({required String key}) {
    return _sharedPreferences.getString(key) ?? '';
  }

  static bool getBool({required String key}) {
    return _sharedPreferences.getBool(key) ?? false;
  }

  static int getInt({required String key}) {
    return _sharedPreferences.getInt(key) ?? 0;
  }

  /// Delete a specific key
  static Future<bool> removeData({required String key}) async {
    return await _sharedPreferences.remove(key);
  }

  /// Clear all stored data
  static Future<bool> clearAllData() async {
    return await _sharedPreferences.clear();
  }

  /// Check if key already exists
  static bool containsKey({required String key}) {
    return _sharedPreferences.containsKey(key);
  }
}