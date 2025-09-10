import '../../data/network/dto/currency_dto.dart';
import '../../data/network/requests/currencies_request.dart';
import '../../data/repos/network_repo.dart';
import '../mappers/currency_mapper.dart';
import '../models/currency_model.dart';
import '../ui_models/currencies_ui_model.dart';

class CurrencyUseCase {
  final NetworkRepo _networkRepo;
  final CurrencyMapper _currencyMapper;
  final LocalRepo _localRepo;

  CurrencyUseCase(this._networkRepo, this._currencyMapper, this._localRepo);

  Future<CurrencyUiModel> fetchCurrencies({required CurrenciesRequest request}) async {
    final currenciesResponse = await _networkRepo.fetchCurrenciesResponse(request: request);
    final dtoList = currenciesResponse.dtoList;
    final currenciesList = <CurrencyModel>[];

    if (currenciesResponse.dtoList.isNotEmpty) {
      for (CurrencyDto dto in dtoList) {
        currenciesList.add(_currencyMapper.fromDto(dto));
      }
    }
    final uiModel = CurrencyUiModel(currenciesList: currenciesList, totalPages: currenciesResponse.totalPages);

    return uiModel;
  }

  Future<bool> saveFavoritesCurrencies({required List<CurrencyModel> list}) async {
    final json = {'list': list.map((m) => _currencyMapper.toJson(m)).toList()};
    final jsonString = jsonEncode(json);
    return await _localRepo.saveFavoriteCurrencies(jsonString);
  }

  List<CurrencyModel> loadFavoriteCurrencies() {
    final jsonString = _localRepo.loadFavoriteCurrencies();
    if (jsonString != null) {
      final json = jsonDecode(jsonString);
      final list = List<CurrencyModel>.from(json['list']!.map((j) => _currencyMapper.fromJson(j)));
      return list;
    }
    return [];
  }

  Future<bool> removeFavoriteCurrencies() async {
    return _localRepo.removeFavoriteCurrencies();
  }
}
