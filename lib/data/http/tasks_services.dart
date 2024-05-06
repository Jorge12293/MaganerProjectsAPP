import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:manager_projects_app/data/global/apis.dart';
import 'package:manager_projects_app/data/global/header_http.dart';
import 'package:manager_projects_app/data/global/urls.dart';
import 'package:manager_projects_app/infrastructure/domain/dto/task_update_status_dto.dart';
import 'package:manager_projects_app/infrastructure/domain/models/task.dart';

class TaskServices {
  static Future<http.Response> listTasks() async {
    Uri url = Uri.parse(AppUrls.urlTasks);
    http.Response response =
        await http.get(url).timeout(Duration(seconds: AppApis.timeoutHttp));
    return response;
  }

  static Future<http.Response> listTasksByUserId(int userId) async {
    Uri url = Uri.parse('${AppUrls.urlTasks}/user/$userId');
    http.Response response =
        await http.get(url).timeout(Duration(seconds: AppApis.timeoutHttp));
    return response;
  }

  static Future<http.Response> addTask(Task task) async {
    Uri url = Uri.parse(AppUrls.urlTasks);
    http.Response response = await http
        .post(url, body: jsonEncode(task), headers: getHeadersHttp)
        .timeout(Duration(seconds: AppApis.timeoutHttp));
    return response;
  }

  static Future<http.Response> updateTask(int id, Task task) async {
    Uri url = Uri.parse("${AppUrls.urlTasks}/$id");
    http.Response response = await http
        .put(url, body: jsonEncode(task), headers: getHeadersHttp)
        .timeout(Duration(seconds: AppApis.timeoutHttp));
    return response;
  }

  static Future<http.Response> updateStatusTask(
      int id, TaskUpdateStatusDto task) async {
    Uri url = Uri.parse("${AppUrls.urlTasks}/status/$id");
    http.Response response = await http
        .put(url, body: jsonEncode(task), headers: getHeadersHttp)
        .timeout(Duration(seconds: AppApis.timeoutHttp));
    return response;
  }

  static Future<http.Response> deleteTask(int id) async {
    Uri url = Uri.parse("${AppUrls.urlTasks}/$id");
    http.Response response = await http
        .delete(url, headers: getHeadersHttp)
        .timeout(Duration(seconds: AppApis.timeoutHttp));
    return response;
  }
}
