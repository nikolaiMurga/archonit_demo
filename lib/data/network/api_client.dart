import '../../../data/network/requests/currencies_request.dart';

abstract class ApiClient {
  Future<Map<String, dynamic>> fetchCurrenciesResponse({required CurrenciesRequest request});
}
