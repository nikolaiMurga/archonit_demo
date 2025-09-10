import 'package:archonit_demo/domain/mappers/currency_mapper.dart';
import 'package:archonit_demo/domain/models/paginated_currencies.dart';

import '../../../data/network/requests/currencies_request.dart';
import '../../domain/models/currency.dart';
import '../network/api_client.dart';
import '../network/dto/currency_dto.dart';
import '../network/responses/currencies_response.dart';

class NetworkRepo {
  final ApiClient _apiClient;
  final CurrencyMapper _currencyMapper;

  NetworkRepo(this._apiClient, this._currencyMapper);

  Future<PaginatedCurrencies> fetchCurrenciesResponse({required CurrenciesRequest request}) async {
    final data = await _apiClient.fetchCurrenciesResponse(request: request);
    final resp = CurrenciesResponse.fromJson(data);
    final dtoList = resp.dtoList;

    final currenciesList = <Currency>[];

    if (dtoList.isNotEmpty) {
      for (CurrencyDto dto in dtoList) {
        currenciesList.add(_currencyMapper.fromDto(dto));
      }
    }
    return PaginatedCurrencies(currenciesList: currenciesList, totalPages: resp.totalPages);
  }
}
