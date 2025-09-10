import '../db/db_client.dart';

class LocalRepo {
  final DbClient _dbClient;

  LocalRepo(this._dbClient);

  Future<bool> saveFavoriteCurrenciesList(String jsonString) async {
    return await _dbClient.saveFavoriteCurrenciesList(jsonString);
  }

  String? loadFavoriteCurrenciesList() {
    return _dbClient.loadFavoriteCurrenciesList();
  }

  Future<bool> removeFavoriteCurrenciesList() async {
    return await _dbClient.removeFavoriteCurrenciesList();
  }
}
