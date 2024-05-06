import 'package:http/http.dart' as http;
import 'dart:convert';

String  formatApiResponse (http.Response response)=> jsonEncode(jsonDecode(utf8.decode(response.bodyBytes)));