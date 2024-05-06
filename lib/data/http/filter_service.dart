import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:manager_projects_app/data/global/apis.dart';
import 'package:manager_projects_app/data/global/header_http.dart';
import 'package:manager_projects_app/data/global/urls.dart';
import 'package:manager_projects_app/infrastructure/domain/models/filter_data.dart';

class FilterServices {
  static Future<http.Response> getFilters(FilterData filterData) async {
    Uri url = Uri.parse(AppUrls.urlFilters);
    http.Response response = await http
        .post(url,
            body: jsonEncode(jsonDecode(jsonEncode(filterData.toJson()))),
            headers: getHeadersHttp)
        .timeout(Duration(seconds: AppApis.timeoutHttp));
    return response;
  }
}
