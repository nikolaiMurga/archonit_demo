import '../../data/network/requests/currencies_request.dart';
import '../../data/repos/local_repo.dart';
import '../../data/repos/network_repo.dart';
import '../models/currency.dart';
import '../models/paginated_currencies.dart';

class CurrencyUseCase {
  final NetworkRepo _networkRepo;
  final LocalRepo _localRepo;

  CurrencyUseCase(this._networkRepo, this._localRepo);

  Future<PaginatedCurrencies> fetchCurrencies({required CurrenciesRequest request}) async {
    return await _networkRepo.fetchCurrenciesResponse(request: request);
  }

  Future<bool> saveFavoritesCurrencies({required List<Currency> list}) async {
    return await _localRepo.saveFavoriteCurrencies(list: list);
  }

  Future<List<Currency>> loadFavoriteCurrencies() async {
    return await _localRepo.loadFavoriteCurrencies();
  }

  Future<bool> removeFavoriteCurrencies() async {
    return _localRepo.removeFavoriteCurrencies();
  }
}
