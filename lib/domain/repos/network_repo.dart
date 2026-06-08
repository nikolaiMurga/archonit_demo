import '../../data/network/requests/currencies_request.dart';
import '../models/paginated_currencies.dart';

abstract class NetworkRepo {
  Future<PaginatedCurrencies> fetchCurrenciesResponse({required CurrenciesRequest request});
}