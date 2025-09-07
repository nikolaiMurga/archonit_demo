import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../../domain/mixins/http_exception_mixin.dart';
import '../../resources/app_strings.dart';
import 'api_client.dart';
import 'endpoints.dart';
import 'params.dart';

class ApiClientHttpImpl with HttpExceptionMixin implements ApiClient {
  final Params _params;

  ApiClientHttpImpl(this._params);

  // GET
  @override
  Future<Map<String, dynamic>> get({required String endpoint, required Map<String, dynamic> queryParams}) async {
    final queryString = Uri(queryParameters: queryParams);
    final url = '${Endpoints.baseUrl}$endpoint$queryString';
    final call = http.get(Uri.parse(url), headers: _params.getHeaders(token: dotenv.env[AppStrings.apiToken]));
    final resp = await handleResponseStatus(apiCall: call);
    final body = utf8.decode(resp.bodyBytes);
    final data = jsonDecode(body);
    return data;
  }
}
