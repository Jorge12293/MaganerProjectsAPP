import 'dart:convert';
import 'dart:developer';

import 'package:manager_projects_app/data/http/filter_service.dart';
import 'package:manager_projects_app/helpers/methods_api/api_response.dart';
import 'package:manager_projects_app/helpers/methods_api/format_api.dart';
import 'package:manager_projects_app/infrastructure/domain/models/filter_data.dart';
import 'package:manager_projects_app/infrastructure/domain/responses/filter_data_response.dart';
import 'package:manager_projects_app/infrastructure/domain/responses/response_http.dart';

class FiltersRepository {

    static Future<ApiResponse<FilterDataResponse?>> getFilter(FilterData filterData) async {
    try {
      final dataResponse = await FilterServices.getFilters(filterData);
      ResponseHttp response = ResponseHttp.fromJson(jsonDecode(formatApiResponse(dataResponse)));
     print(jsonEncode(dataResponse.body));
     
      return ApiResponse<FilterDataResponse?>(
          message: response.message,
          success: response.success,
           data: response.success
              ? FilterDataResponse.fromRawJson(jsonEncode(response.data))
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


