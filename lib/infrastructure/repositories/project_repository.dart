import 'dart:convert';
import 'dart:developer';

import 'package:manager_projects_app/data/http/projects_services.dart';
import 'package:manager_projects_app/helpers/methods_api/api_response.dart';
import 'package:manager_projects_app/helpers/methods_api/format_api.dart';
import 'package:manager_projects_app/infrastructure/domain/models/project.dart';
import 'package:manager_projects_app/infrastructure/domain/responses/response_http.dart';

class ProjectRepository {
  
  static Future<ApiResponse<List<Project>>> listProjects() async {
    try {
      final dataResponse = await ProjectServices.listProjects();
      ResponseHttp response = ResponseHttp.fromJson(jsonDecode(formatApiResponse(dataResponse)));
      return ApiResponse<List<Project>>(
          message: response.message,
          success: response.success,
          data: response.success
              ? responseListProjectFromJson(jsonEncode(response.data))
              : [],
          errors: response.errors);
    } catch (e) {
      return ApiResponse(
          data: [],
          success: false,
          message: "Ocurrió un error intente más tarde");
    }
  }


  static Future<ApiResponse<Project?>> getProject(int id) async {
    try {
      final dataResponse = await ProjectServices.getProject(id);
      ResponseHttp response = ResponseHttp.fromJson(jsonDecode(formatApiResponse(dataResponse)));
      return ApiResponse<Project?>(
          message: response.message,
          success: response.success,
          data: response.success
              ? Project.fromJson(jsonDecode(jsonEncode(response.data)))
              : null,
          errors: response.errors);
    } catch (e) {
      return ApiResponse(
          data: null,
          success: false,
          message: "Ocurrió un error intente más tarde");
    }
  }

  static Future<ApiResponse<Project?>> addProject(Project project) async {
    try {
      final dataResponse = await ProjectServices.addProject(project);
      ResponseHttp response = ResponseHttp.fromJson(jsonDecode(formatApiResponse(dataResponse)));
      return ApiResponse<Project?>(
          message: response.message,
          success: response.success,
          data: response.success
              ? Project.fromJson(jsonDecode(jsonEncode(response.data)))
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
  
  static Future<ApiResponse<Project?>> updateProject(int id,Project project) async {
    try {
      final dataResponse = await ProjectServices.updateProject(id,project);
      ResponseHttp response = ResponseHttp.fromJson(jsonDecode(formatApiResponse(dataResponse)));
      return ApiResponse<Project?>(
          message: response.message,
          success: response.success,
          data: response.success
              ? Project.fromJson(jsonDecode(jsonEncode(response.data)))
              : null,
          errors: response.errors);
    } catch (e, track) {
      print(track);
      return ApiResponse(
          data: null,
          success: false,
          message: "Ocurrió un error intente más tarde");
    }
  }

  static Future<ApiResponse<Project?>> deleteProject(int id) async {
    try {
      final dataResponse = await ProjectServices.deleteProject(id);
      ResponseHttp response = ResponseHttp.fromJson(jsonDecode(formatApiResponse(dataResponse)));
      return ApiResponse<Project?>(
          message: response.message,
          success: response.success,
          data: response.success
              ? Project.fromJson(jsonDecode(jsonEncode(response.data)))
              : null,
          errors: response.errors);
    } catch (e, track) {
      print(track);
      return ApiResponse(
          data: null,
          success: false,
          message: "Ocurrió un error intente más tarde");
    }
  }
}


