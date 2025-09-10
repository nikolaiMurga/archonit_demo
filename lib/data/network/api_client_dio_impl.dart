import 'package:dio/dio.dart';

import '../../domain/mixins/dio_exception_mixin.dart';
import 'api_client.dart';
import 'endpoints.dart';
import 'params.dart';
import '../../../data/network/requests/currencies_request.dart';

class ApiClientDioImpl with DioExceptionMixin implements ApiClient {
  final Dio _dio;
  final Params _params;

  ApiClientDioImpl(this._dio, this._params);

  // GET
  Future<Response> _get({required String endpoint, required Map<String, dynamic> queryParams}) async {
    return await dioExceptionHandle(apiCall: _dio.get(endpoint, queryParameters: queryParams));
  }

  @override
  Future<Map<String, dynamic>> fetchCurrenciesResponse({required CurrenciesRequest request}) async {
    final queryParams = _params.getCurrenciesRequestQueryParams(request: request);
    final resp = await _get(endpoint: Endpoints.fetchAssets, queryParams: queryParams);
    return resp.data;
  }
}
