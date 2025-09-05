import 'dart:convert';

import 'package:dio/dio.dart';

import '../../domain/mixins/dio_exception_mixin.dart';
import 'api_client.dart';

class ApiClientDioImpl with DioExceptionMixin implements ApiClient {
  final Dio _dio;

  ApiClientDioImpl(this._dio);

  // GET
  @override
  Future<String> get({required String url, Map<String, dynamic>? queryParameters}) async {
    final response = await dioExceptionHandle(apiCall: _dio.get(url, queryParameters: queryParameters));
    final data = response.data;
    if (data is Map<String, dynamic> || data is List<dynamic>) {
      return jsonEncode(data);
    }
    return data?.toString() ?? '';
  }
}
