import 'package:archonit_demo/data/network/requests/currencies_request.dart';
import 'package:archonit_demo/domain/repos/network_repo.dart';
import 'package:archonit_demo/domain/models/paginated_currencies.dart';

class CurrencyUseCase {
  final NetworkRepo _networkRepo;

  CurrencyUseCase(this._networkRepo);

  Future<PaginatedCurrencies> fetchCurrencies({required CurrenciesRequest request}) async {
    return _networkRepo.fetchCurrenciesResponse(request: request);
  }
}
