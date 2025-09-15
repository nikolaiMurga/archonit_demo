import 'package:archonit_demo/data/network/api_client.dart';
import 'package:archonit_demo/data/network/endpoints.dart';
import 'package:archonit_demo/data/network/params.dart';
import 'package:archonit_demo/data/network/requests/currencies_request.dart';
import 'package:archonit_demo/data/network/responses/currencies_response.dart';
import 'package:archonit_demo/domain/mixins/dio_exception_mixin.dart';
import 'package:dio/dio.dart';

class ApiClientDioImpl with DioExceptionMixin implements ApiClient {
  final Dio _dio;
  final Params _params;

  ApiClientDioImpl(this._dio, this._params);

  // GET
  Future<Response> _get({required String endpoint, required Map<String, dynamic> queryParams}) async {
    return dioExceptionHandle(apiCall: _dio.get(endpoint, queryParameters: queryParams));
  }

  @override
  Future<CurrenciesResponse> fetchCurrenciesResponse({required CurrenciesRequest request}) async {
    final queryParams = _params.getCurrenciesRequestQueryParams(request: request);
    final resp = await _get(endpoint: Endpoints.fetchAssets, queryParams: queryParams);
    return CurrenciesResponse.fromJson(resp.data);
  }
}
