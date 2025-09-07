import '../../domain/models/currency_model.dart';

abstract class DbClient {
  Future<bool> saveFavoriteCurrenciesList(List<CurrencyModel> list);

  List<CurrencyModel> loadFavoriteCurrenciesList();

  Future<bool> removeFavoriteCurrenciesList();
}
