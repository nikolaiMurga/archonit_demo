abstract class DbClient {
  Future<bool> saveFavoriteCurrencies(String jsonString);

  String? loadFavoriteCurrencies();

  Future<bool> removeFavoriteCurrencies();
}
