import 'package:archonit_demo/domain/ui_models/home_ui_model.dart';

import '../../data/network/dtos/currency_dto.dart';
import '../../data/network/requests/assets_request.dart';
import '../../data/repos/network_repo.dart';
import '../models/currency_model.dart';

class CurrencyUseCase {
  final NetworkRepo _networkRepo;

  CurrencyUseCase(this._networkRepo);

  Future<HomeUiModel> fetchCurrenciesList({required AssetsRequest request}) async {
    final resp = await _networkRepo.fetchCurrenciesResponse(request: request);
    final dtoList = resp.currencyDtoList;

    final List<CurrencyModel> currencyModelList = [];

    if (dtoList != null && dtoList.isNotEmpty) {
      for (CurrencyDto dto in dtoList) {
        final currencyModel = CurrencyModel.fromDto(dto);
        currencyModelList.add(currencyModel);
      }
    }
    final homeUiModel = HomeUiModel(currencyModelList: currencyModelList);
    return homeUiModel;
  }

// could be here save currency for caching favourites for example
// Future<void> saveFavourites() async {}
}
