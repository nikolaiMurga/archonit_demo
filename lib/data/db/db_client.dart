abstract class DbClient {
  Future<bool> saveFavoriteCurrenciesList(String jsonString);

  String? loadFavoriteCurrenciesList();

  Future<bool> removeFavoriteCurrenciesList();
}
