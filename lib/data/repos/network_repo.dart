import 'dart:convert';

import '../network/api_client.dart';
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
    final data = await _apiClient.get(url: '${Endpoints.baseUrl}${Endpoints.fetchAssets}$queryString');
    return AssetsResponse.fromJson(data);
  }
}
