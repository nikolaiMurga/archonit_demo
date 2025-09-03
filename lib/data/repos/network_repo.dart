import 'package:archonit_demo/data/network/api_client.dart';
import 'package:archonit_demo/data/network/endpoints.dart';

class NetworkRepo {
  final ApiClient _apiClient;

  NetworkRepo(this._apiClient);

  Future<void> fetchCurrenciesResponse() async {
    final response = await _apiClient.get(endpoint: Endpoints.fetchMarket);
    print('object');
  }
}
