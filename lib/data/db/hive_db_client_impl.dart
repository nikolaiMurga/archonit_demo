import 'package:archonit_demo/data/db/db_client.dart';
import 'package:archonit_demo/domain/models/currency_model.dart';

class HiveDbClientImpl implements DbClient {
  @override
  List<CurrencyModel> loadFavoriteCurrenciesList() {
    // TODO: implement loadFavoriteCurrenciesList
    throw UnimplementedError();
  }

  @override
  Future<bool> removeFavoriteCurrenciesList() {
    // TODO: implement removeFavoriteCurrenciesList
    throw UnimplementedError();
  }

  @override
  Future<bool> saveFavoriteCurrenciesList(List<CurrencyModel> list) {
    // TODO: implement saveFavoriteCurrenciesList
    throw UnimplementedError();
  }

}