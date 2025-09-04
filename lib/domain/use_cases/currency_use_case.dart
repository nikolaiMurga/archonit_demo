import 'package:archonit_demo/domain/mixins/random_color_generator_mixin.dart';
import 'package:archonit_demo/domain/models/currency_model.dart';

import '../../data/network/dtos/currency_dto.dart';
import '../../data/repos/network_repo.dart';

class CurrencyUseCase with RandomColorGeneratorMixin {
  final NetworkRepo _networkRepo;

  CurrencyUseCase(this._networkRepo);

  Future<List<CurrencyModel>> fetchCurrenciesList() async {
    final resp = await _networkRepo.fetchCurrenciesResponse();
    final dtoList = resp.currencyDtoList;

    final List<CurrencyModel> currencyModelList = [];

    if (dtoList != null && dtoList.isNotEmpty) {
      for (CurrencyDto _ in dtoList) {
        final currencyModel = CurrencyModel.fromDto(_);
        currencyModelList.add(currencyModel);
      }
    }
    return currencyModelList;
  }

// could be here save currency for caching favourites for example
// Future<void> saveFavourites() async {}
}
