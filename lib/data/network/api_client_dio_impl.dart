import 'package:dio/dio.dart' as http;
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'api_client.dart';
import 'params.dart';

class ApiClientDioImpl implements ApiClient {
  final Params _params;
  final Dio _dio;

  ApiClientDioImpl(this._params, this._dio);

  // GET
  @override
  Future<Response> get({required String endpoint}) async {
    final response = await _dio.get(
      endpoint,
      options: http.Options(
        headers: _params.getHeaders(token: dotenv.env['API_TOKEN']),
      ),
    );
    return response;
  }
}
