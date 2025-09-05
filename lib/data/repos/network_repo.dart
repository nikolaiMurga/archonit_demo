import 'dart:convert';

import '../network/api_client.dart';
import '../network/api_client_dio_impl.dart';
import '../network/endpoints.dart';
import '../network/params.dart';
import '../network/requests/assets_request.dart';
import '../network/responses /assets_response.dart';

class NetworkRepo {
  final ApiClient _apiClient;
  final Params _params;

  NetworkRepo(this._apiClient, this._params);

  Future<AssetsResponse> fetchCurrenciesResponse({required AssetsRequest request}) async {
    final queryString = Uri(queryParameters: _params.getAssetsRequestQueryParams(request: request));
    final response = await _apiClient.get(url: '${Endpoints.baseUrl}${Endpoints.fetchAssets}$queryString');
    // print(_apiClient.runtimeType);
    if (_apiClient is ApiClientDioImpl) {
      return AssetsResponse.fromJson(response.data);
    } else {
      String body = utf8.decode(response.bodyBytes);
      return AssetsResponse.fromJson(jsonDecode(body));
    }
  }
}
