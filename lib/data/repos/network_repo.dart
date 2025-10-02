import 'package:archonit_demo/data/mappers/currency_mapper.dart';
import 'package:archonit_demo/data/network/api_client.dart';
import 'package:archonit_demo/data/network/dto/currency_dto.dart';
import 'package:archonit_demo/data/network/endpoints.dart';
import 'package:archonit_demo/data/network/params.dart';
import 'package:archonit_demo/data/network/requests/currencies_request.dart';
import 'package:archonit_demo/data/network/responses/currencies_response.dart';
import 'package:archonit_demo/domain/models/currency.dart';
import 'package:archonit_demo/domain/models/paginated_currencies.dart';

class NetworkRepo {
  final ApiClient _apiClient;
  final CurrencyMapper _currencyMapper;
  final Params _params;

  NetworkRepo(this._apiClient, this._currencyMapper, this._params);

  Future<PaginatedCurrencies> fetchCurrenciesResponse({required CurrenciesRequest request}) async {
    final queryParams = _params.getCurrenciesRequestQueryParams(request: request);
    final data = await _apiClient.get(endpoint: Endpoints.fetchAssets, queryParams: queryParams);
    final currResp = CurrenciesResponse.fromJson(data);
    final dtoList = currResp.dtoList;
    final currenciesList = <Currency>[];
    if (dtoList.isNotEmpty) {
      for (CurrencyDto dto in dtoList) {
        currenciesList.add(_currencyMapper.fromDto(dto));
      }
    }
    return PaginatedCurrencies(currenciesList: currenciesList, totalPages: currResp.totalPages);
  }
}
