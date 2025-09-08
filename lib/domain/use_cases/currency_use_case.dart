import '../../data/network/requests/assets_request.dart';
import '../../data/network/responses/assets_response.dart';
import '../../data/repos/local_repo.dart';
import '../../data/repos/network_repo.dart';

class CurrencyUseCase {
  final NetworkRepo _networkRepo;
  final LocalRepo _localRepo;

  CurrencyUseCase(this._networkRepo, this._localRepo);

  Future<CurrenciesResponse> fetchCurrencies({required CurrenciesRequest request}) async {
    final currenciesResponse = await _networkRepo.fetchCurrenciesResponse(request: request);
    return currenciesResponse;
  }
}
