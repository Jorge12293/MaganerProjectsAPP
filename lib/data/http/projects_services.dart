import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:manager_projects_app/data/global/apis.dart';
import 'package:manager_projects_app/data/global/header_http.dart';
import 'package:manager_projects_app/data/global/urls.dart';
import 'package:manager_projects_app/infrastructure/domain/models/project.dart';

class ProjectServices {
  static Future<http.Response> listProjects() async {
    Uri url = Uri.parse(AppUrls.urlProjects);
    http.Response response = await http.get(url)
      .timeout(Duration(seconds: AppApis.timeoutHttp));
    return response;
  }

  static Future<http.Response> getProject(int id) async {
    Uri url = Uri.parse("${AppUrls.urlProjects}/$id");
    http.Response response =await http.get(url)
      .timeout(Duration(seconds: AppApis.timeoutHttp));
    return response;
  }

  static Future<http.Response> addProject(Project project) async {
    Uri url = Uri.parse(AppUrls.urlProjects);
    http.Response response = await http
        .post(url, body: jsonEncode(project), headers: getHeadersHttp)
        .timeout(Duration(seconds: AppApis.timeoutHttp));
    return response;
  }

  static Future<http.Response> updateProject(int id, Project project) async {
    Uri url = Uri.parse("${AppUrls.urlProjects}/$id");
    http.Response response = await http
        .put(url, body: jsonEncode(project), headers: getHeadersHttp)
        .timeout(Duration(seconds: AppApis.timeoutHttp));
    return response;
  }

  static Future<http.Response> deleteProject(int id) async {
    Uri url = Uri.parse("${AppUrls.urlProjects}/$id");
    http.Response response = await http.delete(url)
      .timeout(Duration(seconds: AppApis.timeoutHttp));
    return response;
  }


}
