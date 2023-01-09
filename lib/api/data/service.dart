import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hubia_menu_app/app/exceptions/api_exception.dart';

class MainService {
  final BuildContext context;

  MainService(this.context);

  String apiUrl = dotenv.get("API_URL");
  final _headers = {
    'Authorization': dotenv.get("API_AUTH"),
    'Content-Type': 'application/json'
  };

  get headers {
    // if (User.instance is User && User.instance!.accessToken is String) {
    //   _headers['Authorization'] = "Bearer ${User.instance!.accessToken!}";
    // } else {
    _headers['Authorization'] = dotenv.get("API_AUTH");
    // }
    return _headers;
  }

  void setUrl(String newUrl) {
    if (Uri.tryParse(newUrl) != null) {
      apiUrl = newUrl;
    }
  }

  Future<dynamic> post(String path, {dynamic data, String? host}) {
    final url = Uri.parse(host == null ? "$apiUrl$path" : "$host$path");
    debugPrint("POST:$url");
    debugPrint("Body: ${jsonEncode(data)}");
    debugPrint("Headers: $headers");
    return http
        .post(url, body: jsonEncode(data), headers: headers)
        .then(_validateResponse);
  }

  Future<dynamic> get(String path,
      {Map<String, dynamic>? queryParams, String? host}) async {
    final url = Uri.parse(host == null ? "$apiUrl$path" : "$host$path")
        .replace(queryParameters: queryParams);
    debugPrint("GET:$url");
    debugPrint("Headers: $headers");
    return http.get(url, headers: headers).then(_validateResponse);
  }

  Future<dynamic> put(String path, {dynamic data, String? host}) async {
    final url = Uri.parse(host == null ? "$apiUrl$path" : "$host$path");
    debugPrint("PUT:$url");
    debugPrint("Body: ${jsonEncode(data)}");
    debugPrint("Headers: $headers");
    return http
        .put(url, body: jsonEncode(data), headers: headers)
        .then(_validateResponse);
  }

  Future<dynamic> delete(String path, {String? host}) {
    final url = Uri.parse(host == null ? "$apiUrl$path" : "$host$path");
    debugPrint("DELETE:$url");
    debugPrint("Headers: $headers");
    return http.delete(url, headers: headers).then(_validateResponse);
  }

  Future<dynamic> sendRequest(http.Request request) {
    return request.send().then((value) async =>
        _validateResponse(await http.Response.fromStream(value)));
  }

  Future<dynamic> _validateResponse(http.Response response) async {
    debugPrint("Response: ${response.body}");
    debugPrint("Status Code: ${response.statusCode}");
    if (![200, 203].contains(response.statusCode)) {
      return _validateError(response);
    }

    Map<String, dynamic> body = jsonDecode(response.body);

    if (body['status'] == 200 || body['status'] == null) return body;

    throw ApiException(responseBody: body);
  }

  void _validateError(http.Response response) {
    if ([401, 403].contains(response.statusCode)) {
      print('Invalid section');
    }
    throw http.ClientException(response.reasonPhrase ?? "Unknown error");
  }
}
