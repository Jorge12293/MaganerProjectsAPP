class ApiResponse<T> {
  T data;
  bool success;
  String message;
  Map<String, String>? errors;
  ApiResponse(
      {required this.data,
      this.success = true,
      this.message = "OK",
      this.errors});
}
