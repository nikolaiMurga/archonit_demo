import '../db/db_client.dart';

class LocalRepo {
  final DbClient _dbClient;

  LocalRepo(this._dbClient);

  Future<bool> saveFavoriteCurrencies(String jsonString) async {
    return await _dbClient.saveFavoriteCurrencies(jsonString);
  }

  String? loadFavoriteCurrencies() {
    return _dbClient.loadFavoriteCurrencies();
  }

  Future<bool> removeFavoriteCurrencies() async {
    return await _dbClient.removeFavoriteCurrencies();
  }
}
