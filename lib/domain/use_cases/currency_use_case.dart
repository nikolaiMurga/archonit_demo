import '../../data/network/requests/assets_request.dart';
import '../../data/network/responses/assets_response.dart';
import '../../data/repos/network_repo.dart';

class CurrencyUseCase {
  final NetworkRepo _networkRepo;

  CurrencyUseCase(this._networkRepo);

  Future<CurrenciesResponse> fetchCurrencies({required CurrenciesRequest request}) async {
    final currenciesResponse = await _networkRepo.fetchCurrenciesResponse(request: request);
    return currenciesResponse;
  }
}
