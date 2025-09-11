import 'package:archonit_demo/data/network/responses/currencies_response.dart';

import '../../../data/network/requests/currencies_request.dart';

abstract class ApiClient {
  Future<CurrenciesResponse> fetchCurrenciesResponse({required CurrenciesRequest request});
}
