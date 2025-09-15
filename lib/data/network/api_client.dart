import 'package:archonit_demo/data/network/requests/currencies_request.dart';
import 'package:archonit_demo/data/network/responses/currencies_response.dart';

abstract class ApiClient {
  Future<CurrenciesResponse> fetchCurrenciesResponse({required CurrenciesRequest request});
}
