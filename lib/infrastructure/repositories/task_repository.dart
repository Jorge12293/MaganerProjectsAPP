import 'dart:convert';
import 'dart:developer';

import 'package:manager_projects_app/data/http/tasks_services.dart';
import 'package:manager_projects_app/helpers/methods_api/api_response.dart';
import 'package:manager_projects_app/helpers/methods_api/format_api.dart';
import 'package:manager_projects_app/infrastructure/domain/dto/task_update_status_dto.dart';
import 'package:manager_projects_app/infrastructure/domain/models/task.dart';
import 'package:manager_projects_app/infrastructure/domain/responses/response_http.dart';

class TaskRepository {
  static Future<ApiResponse<List<Task>>> listTasks() async {
    try {
     final dataResponse = await TaskServices.listTasks();
      ResponseHttp response =  ResponseHttp.fromJson(jsonDecode(formatApiResponse(dataResponse)));
      return ApiResponse<List<Task>>(
            message: response.message,
            success: response.success,
            data:responseListTaskFromJson(jsonEncode(response.data)) );
    } catch (e) {
      return ApiResponse(
          data: [],
          success: false,
          message: "Ocurrió un error intente más tarde");
    }
  }

  static Future<ApiResponse<List<Task>>> listTasksByUserId(int userId) async {
    try {

     final dataResponse = await TaskServices.listTasksByUserId(userId);
      ResponseHttp response =  ResponseHttp.fromJson(jsonDecode(formatApiResponse(dataResponse)));
      return ApiResponse<List<Task>>(
            message: response.message,
            success: response.success,
            data:responseListTaskFromJson(jsonEncode(response.data)) );
    } catch (e) {
      return ApiResponse(
          data: [],
          success: false,
          message: "Ocurrió un error intente más tarde");
    }
  }


    static Future<ApiResponse<Task?>> addTask(Task task) async {
    try {
      final dataResponse = await TaskServices.addTask(task);
      ResponseHttp response = ResponseHttp.fromJson(jsonDecode(formatApiResponse(dataResponse)));
      return ApiResponse<Task?>(
          message: response.message,
          success: response.success,
          data: response.success
              ? Task.fromJson(jsonDecode(jsonEncode(response.data)))
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
  static Future<ApiResponse<Task?>> updateTask(int id,Task task) async {
    try {
      final dataResponse = await TaskServices.updateTask(id,task);
      ResponseHttp response = ResponseHttp.fromJson(jsonDecode(formatApiResponse(dataResponse)));
      return ApiResponse<Task?>(
          message: response.message,
          success: response.success,
          data: response.success
              ? Task.fromJson(jsonDecode(jsonEncode(response.data)))
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

  static Future<ApiResponse<Task?>> updateStatusTask(int id,TaskUpdateStatusDto task) async {
    try {
      final dataResponse = await TaskServices.updateStatusTask(id,task);
      ResponseHttp response = ResponseHttp.fromJson(jsonDecode(formatApiResponse(dataResponse)));
      return ApiResponse<Task?>(
          message: response.message,
          success: response.success,
          data: response.success
              ? Task.fromJson(jsonDecode(jsonEncode(response.data)))
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

  static Future<ApiResponse<Task?>> deleteTask(int id) async {
    try {
      final dataResponse = await TaskServices.deleteTask(id);
      ResponseHttp response = ResponseHttp.fromJson(jsonDecode(formatApiResponse(dataResponse)));
      return ApiResponse<Task?>(
          message: response.message,
          success: response.success,
          data: response.success
              ? Task.fromJson(jsonDecode(jsonEncode(response.data)))
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
}
