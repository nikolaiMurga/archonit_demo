import 'package:archonit_demo/data/network/endpoints.dart';

import '../network/api_client.dart';
import '../network/params.dart';
import '../network/requests/assets_request.dart';
import '../network/responses/assets_response.dart';

class NetworkRepo {
  final ApiClient _apiClient;
  final Params _params;

  NetworkRepo(this._apiClient, this._params);

  Future<CurrenciesResponse> fetchCurrenciesResponse({required CurrenciesRequest request}) async {
    final queryParams = _params.getCurrenciesRequestQueryParams(request: request);
    final data = await _apiClient.get(endpoint: Endpoints.fetchAssets, queryParams: queryParams);
    return CurrenciesResponse.fromJson(data);
  }
}
