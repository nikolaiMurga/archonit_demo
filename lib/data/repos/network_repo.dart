import '../../../data/network/requests/currencies_request.dart';
import '../network/responses/currencies_response.dart';

class NetworkRepo {
  final dynamic _apiClient;

  NetworkRepo(this._apiClient);

  Future<CurrenciesResponse> fetchCurrenciesResponse({required CurrenciesRequest request}) async {
    final data = await _apiClient.fetchCurrenciesResponse(request: request);
    return CurrenciesResponse.fromJson(data);
  }
}
