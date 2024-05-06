import 'dart:convert';
import 'dart:developer';

import 'package:manager_projects_app/data/http/users_services.dart';
import 'package:manager_projects_app/helpers/methods_api/api_response.dart';
import 'package:manager_projects_app/helpers/methods_api/format_api.dart';
import 'package:manager_projects_app/infrastructure/domain/models/user_app.dart';
import 'package:manager_projects_app/infrastructure/domain/responses/response_http.dart';

class UserRepository {
  static Future<ApiResponse<List<UserApp>>> listUsers() async {
    final dataResponse = await UserServices.listUsers();
    ResponseHttp response =
        ResponseHttp.fromJson(jsonDecode(formatApiResponse(dataResponse)));
    return ApiResponse<List<UserApp>>(
        message: response.message,
        success: response.success,
        data: responseListUserFromJson(jsonEncode(response.data)));
  }

  static Future<ApiResponse<UserApp?>> addUser(UserApp user) async {
    try {
      final dataResponse = await UserServices.addUser(user);
      ResponseHttp response = ResponseHttp.fromJson(jsonDecode(formatApiResponse(dataResponse)));
      
      return ApiResponse<UserApp?>(
          message: response.message,
          success: response.success,
          data: response.success
              ? UserApp.fromJson(jsonDecode(jsonEncode(response.data)))
              : null,
          errors: response.errors);
    } catch (e, track) {
      log(track.toString());
      return ApiResponse(
          data: null,
          success: false,
          message: "Ocurrió un error intente más tarde");
    }
  }
  

    static Future<ApiResponse<UserApp?>> getUserUid(String uid) async {
    try {
      final dataResponse = await UserServices.getUserUID(uid);
      ResponseHttp response = ResponseHttp.fromJson(jsonDecode(formatApiResponse(dataResponse)));
      return ApiResponse<UserApp?>(
          message: response.message,
          success: response.success,
          data: response.success
              ? UserApp.fromJson(jsonDecode(jsonEncode(response.data)))
              : null,
          errors: response.errors);
    } catch (e) {
      return ApiResponse(
          data: null,
          success: false,
          message: "Ocurrió un error intente más tarde");
    }
  }
}
