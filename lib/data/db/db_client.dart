abstract class DbClient {
  Future<bool> saveFavoriteCurrencies(String jsonString);

  Future<String?> loadFavoriteCurrencies();

  Future<bool> removeFavoriteCurrencies();
}
