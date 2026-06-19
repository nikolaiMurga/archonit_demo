import '../../data/network/requests/currencies_request.dart';
import '../models/currency.dart';
import '../repos/network_repo.dart';

class CurrencyUseCase {
  final NetworkRepo _networkRepo;

  final List<Currency> _cachedCurrencies = [];
  int _nextPage = 1;
  bool _isLastPage = false;

  CurrencyUseCase(this._networkRepo);

  List<Currency> get currentCurrencies => List<Currency>.from(_cachedCurrencies);

  bool get isLastPage => _isLastPage;

  Future<List<Currency>> fetchCurrencies() async {
    if (_isLastPage) return _cachedCurrencies;

    final request = CurrenciesRequest(page: _nextPage);
    final paginatedCurrencies = await _networkRepo.fetchCurrenciesResponse(request: request);

    if (paginatedCurrencies.currenciesList.isNotEmpty) {
      _cachedCurrencies.addAll(paginatedCurrencies.currenciesList);
      _isLastPage = _nextPage == paginatedCurrencies.totalPages;
      _nextPage++;
    } else {
      _isLastPage = true;
    }

    return List<Currency>.from(_cachedCurrencies);
  }

  void resetPagination() {
    _cachedCurrencies.clear();
    _nextPage = 1;
    _isLastPage = false;
  }
}
