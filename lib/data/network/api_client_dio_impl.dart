import 'package:dio/dio.dart';

import '../../domain/mixins/dio_exception_mixin.dart';
import 'api_client.dart';

class ApiClientDioImpl with DioExceptionMixin implements ApiClient {
  final Dio _dio;

  ApiClientDioImpl(this._dio);

  // GET
  @override
  Future<Map<String, dynamic>> get({required String endpoint, required Map<String, dynamic> queryParams}) async {
    final resp = await dioExceptionHandle(apiCall: _dio.get(endpoint, queryParameters: queryParams));
    return resp.data;
  }
}
