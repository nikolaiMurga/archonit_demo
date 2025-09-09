import '../../data/network/requests/assets_request.dart';
import '../../data/repos/network_repo.dart';
import '../mappers/currency_mapper.dart';
import '../ui_models/currencies_ui_model.dart';

class CurrencyUseCase {
  final NetworkRepo _networkRepo;
  final CurrencyMapper _currencyMapper;

  CurrencyUseCase(this._networkRepo, this._currencyMapper);

  Future<CurrencyUiModel> fetchCurrencies({required CurrenciesRequest request}) async {
    final currenciesResponse = await _networkRepo.fetchCurrenciesResponse(request: request);
    final currenciesList = _currencyMapper.fromDtoList(currenciesResponse.dtoList);
    final uiModel = CurrencyUiModel(currenciesList: currenciesList, totalPages: currenciesResponse.totalPages);
    return uiModel;
  }
}
