import 'package:dio/dio.dart' as http;
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'api_client.dart';
import 'params.dart';

class ApiClientDioImpl implements ApiClient {
  final Dio _dio;

  ApiClientDioImpl(this._dio);

  // GET
  @override
  Future<Response> get({required String url}) async => await _dio.get(url);
}
