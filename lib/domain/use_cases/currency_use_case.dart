import '../../data/network/requests/currencies_request.dart';
import '../../data/repos/network_repo.dart';
import '../mappers/currency_mapper.dart';
import '../models/paginated_currencies.dart';

class CurrencyUseCase {
  final NetworkRepo _networkRepo;

  CurrencyUseCase(this._networkRepo);

  Future<PaginatedCurrencies> fetchCurrencies({required CurrenciesRequest request}) async {
    return await _networkRepo.fetchCurrenciesResponse(request: request);
  }
}
