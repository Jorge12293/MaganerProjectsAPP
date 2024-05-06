import 'dart:developer';

class ResponseHttp<T> {
  bool success;
  String message;
  T? data;
  Map<String, String>? errors;
  ResponseHttp({
    required this.success,
    required this.message,
    required this.data,
    required this.errors,
  });
  factory ResponseHttp.fromJson(Map<String, dynamic> json) => ResponseHttp(
        success: json["success"],
        message: json["message"],
        data: json["data"],
        errors: json["errors"] != null ? convertToMap(json["errors"]) : null,
      );
}

Map<String, String> convertToMap(dynamic errors) {
  try {
    final jsonMap = errors as Map<String, dynamic>?;
    return jsonMap?.map((key, value) => MapEntry(key, value.toString())) ?? {};
  } catch (e) {
    log('Error convert to map: $e');
    return {};
  }
}
