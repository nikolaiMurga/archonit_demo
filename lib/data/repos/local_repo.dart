import '../../domain/models/currency_model.dart';
import '../db/db_client.dart';

class LocalRepo {
  final DbClient _dbClient;

  LocalRepo(this._dbClient);

  Future<bool> saveFavoriteCurrenciesList({required List<CurrencyModel> list}) async {
    return await _dbClient.saveFavoriteCurrenciesList(list);
  }

  List<CurrencyModel> loadFavoriteCurrenciesList() {
    return _dbClient.loadFavoriteCurrenciesList();
  }

  Future<bool> removeFavoriteCurrenciesList() async {
    return await _dbClient.removeFavoriteCurrenciesList();
  }
}
