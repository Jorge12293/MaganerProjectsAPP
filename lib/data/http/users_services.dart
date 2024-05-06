import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:manager_projects_app/data/global/apis.dart';
import 'package:manager_projects_app/data/global/header_http.dart';
import 'package:manager_projects_app/data/global/urls.dart';
import 'package:manager_projects_app/infrastructure/domain/models/user_app.dart';

class UserServices {
  static Future<http.Response> listUsers() async {
    Uri url = Uri.parse(AppUrls.urlUsers);
      http.Response response =
          await http.get(url).timeout(Duration(seconds: AppApis.timeoutHttp));
      return response;
  }

  static Future<http.Response> addUser(UserApp user) async {
    Uri url = Uri.parse(AppUrls.urlUsers);
    http.Response response = await http
        .post(url, body: jsonEncode(user), headers: getHeadersHttp)
        .timeout(Duration(seconds: AppApis.timeoutHttp));

        print(response.body);
        print(response.statusCode);
    return response;
  }

  static Future<http.Response> getUserUID(String userId) async {
    Uri url = Uri.parse('${AppUrls.urlUsers}/uid/$userId');
      http.Response response =
          await http.get(url).timeout(Duration(seconds: AppApis.timeoutHttp));
      return response;
  }

}
