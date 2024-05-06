import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesBd {
  static Future<String?> getPreference({required String key}) async {
    try {
      final preferences = await SharedPreferences.getInstance();
      return preferences.getString(key);
    } catch (e, track) {
      log(e.toString());
      log(track.toString());
      return null;
    }
  }

  static Future<bool> savePreference(
      {required String key, required String value}) async {
    try {
      final preferences = await SharedPreferences.getInstance();
      return preferences.setString(key, value);
    } catch (e, track) {
      log(e.toString());
      log(track.toString());
      return false;
    }
  }

  static Future<bool> deletePreference({required String key}) async {
    try {
      final preferences = await SharedPreferences.getInstance();
      return preferences.remove(key);
    } catch (e, track) {
      log(e.toString());
      log(track.toString());
      return false;
    }
  }
}
