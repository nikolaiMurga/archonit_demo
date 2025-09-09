import 'package:archonit_demo/data/repos/local_repo.dart';
import 'package:archonit_demo/domain/models/currency_model.dart';

import '../../data/network/requests/assets_request.dart';
import '../../data/repos/network_repo.dart';
import '../mappers/currency_mapper.dart';
import '../ui_models/currencies_ui_model.dart';

class CurrencyUseCase {
  final NetworkRepo _networkRepo;
  final CurrencyMapper _currencyMapper;
  final LocalRepo _localRepo;

  CurrencyUseCase(this._networkRepo, this._currencyMapper, this._localRepo);

  Future<CurrencyUiModel> fetchCurrencies({required CurrenciesRequest request}) async {
    final currenciesResponse = await _networkRepo.fetchCurrenciesResponse(request: request);
    final currenciesList = _currencyMapper.fromDtoList(currenciesResponse.dtoList);
    final uiModel = CurrencyUiModel(currenciesList: currenciesList, totalPages: currenciesResponse.totalPages);
    return uiModel;
  }

  Future<bool> saveFavoritesCurrencies({required List<CurrencyModel> list}) async {
    return await _localRepo.saveFavoriteCurrenciesList(list: list);
  }

  List<CurrencyModel> loadFavoriteCurrencies(){
    return _localRepo.loadFavoriteCurrenciesList();
  }

  Future<bool> removeFavoriteCurrenciesList() async {
    return _localRepo.removeFavoriteCurrenciesList();
  }
}
