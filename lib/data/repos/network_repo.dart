import 'package:archonit_demo/data/mappers/currency_mapper.dart';
import 'package:archonit_demo/data/network/api_client.dart';
import 'package:archonit_demo/data/network/dto/currency_dto.dart';
import 'package:archonit_demo/data/network/requests/currencies_request.dart';
import 'package:archonit_demo/domain/models/currency.dart';
import 'package:archonit_demo/domain/models/paginated_currencies.dart';

class NetworkRepo {
  final ApiClient _apiClient;
  final CurrencyMapper _currencyMapper;

  NetworkRepo(this._apiClient, this._currencyMapper);

  Future<PaginatedCurrencies> fetchCurrenciesResponse({required CurrenciesRequest request}) async {
    final response = await _apiClient.fetchCurrenciesResponse(request: request);
    final dtoList = response.dtoList;
    final currenciesList = <Currency>[];
    if (dtoList.isNotEmpty) {
      for (CurrencyDto dto in dtoList) {
        currenciesList.add(_currencyMapper.fromDto(dto));
      }
    }
    return PaginatedCurrencies(currenciesList: currenciesList, totalPages: response.totalPages);
  }
}
