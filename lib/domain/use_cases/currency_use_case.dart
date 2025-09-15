import 'package:archonit_demo/data/network/requests/currencies_request.dart';
import 'package:archonit_demo/data/repos/local_repo.dart';
import 'package:archonit_demo/data/repos/network_repo.dart';
import 'package:archonit_demo/domain/models/currency.dart';
import 'package:archonit_demo/domain/models/paginated_currencies.dart';

class CurrencyUseCase {
  final NetworkRepo _networkRepo;
  final LocalRepo _localRepo;

  CurrencyUseCase(this._networkRepo, this._localRepo);

  Future<PaginatedCurrencies> fetchCurrencies({required CurrenciesRequest request}) async {
    return _networkRepo.fetchCurrenciesResponse(request: request);
  }

  Future<bool> saveFavoritesCurrencies({required List<Currency> list}) async {
    return _localRepo.saveFavoriteCurrencies(list: list);
  }

  Future<List<Currency>> loadFavoriteCurrencies() async {
    return _localRepo.loadFavoriteCurrencies();
  }

  Future<bool> removeFavoriteCurrencies() async {
    return _localRepo.removeFavoriteCurrencies();
  }
}
