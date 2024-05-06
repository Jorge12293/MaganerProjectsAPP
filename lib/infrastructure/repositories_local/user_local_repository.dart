import 'dart:convert';
import 'dart:developer';

import 'package:manager_projects_app/data/bd_local/local_keys.dart';
import 'package:manager_projects_app/data/bd_local/shared_preferences_bd.dart';
import 'package:manager_projects_app/infrastructure/domain/models/user_app.dart';
//import 'package:manager_projects_app/infrastructure/domain/models/connection_bd.dart';

class UserLocalRepository {
  
  static Future<UserApp?> getUser() async {
    try {
      String? dataString = await SharedPreferencesBd.getPreference(
          key: LocalKeys.keyUser);
      if (dataString == null) return null;
      return UserApp.fromRawJson(dataString);
    } catch (e, track) {
      log(e.toString());
      log(track.toString());
      return null;
    }
  }

  static Future<bool> saveUser( {required UserApp userApp}) async {
    try {
      String data = jsonEncode(userApp);
      return await SharedPreferencesBd.savePreference(
          key: LocalKeys.keyUser, value: data);
    } catch (e, track) {
      log(e.toString());
      log(track.toString());
      return false;
    }
  }

  static Future<bool> deleteUser() async {
    try {
      return await SharedPreferencesBd.deletePreference(key: LocalKeys.keyUser);
    } catch (e, track) {
      log(e.toString());
      log(track.toString());
      return false;
    }
  }
}
