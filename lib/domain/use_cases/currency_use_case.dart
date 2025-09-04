import '../../data/network/dtos/currency_dto.dart';
import '../../data/network/requests/assets_request.dart';
import '../../data/repos/network_repo.dart';
import '../models/currency_model.dart';

class CurrencyUseCase {
  final NetworkRepo _networkRepo;

  CurrencyUseCase(this._networkRepo);

  // todo implement mock home ui model
  // todo should return home ui model with total pages to implement last page logic
  Future<List<CurrencyModel>> fetchCurrenciesList({required AssetsRequest request}) async {
    final resp = await _networkRepo.fetchCurrenciesResponse();
    final dtoList = resp.currencyDtoList;

    final List<CurrencyModel> currencyModelList = [];

    if (dtoList != null && dtoList.isNotEmpty) {
      for (CurrencyDto dto in dtoList) {
        final currencyModel = CurrencyModel.fromDto(dto);
        currencyModelList.add(currencyModel);
      }
    }
    return currencyModelList;
  }

// could be here save currency for caching favourites for example
// Future<void> saveFavourites() async {}
}
