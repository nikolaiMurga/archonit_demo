import '../models/currency.dart';

abstract class LocalRepo {
  Future<bool> saveFavoriteCurrencies({required List<Currency> list});

  List<Currency> loadFavoriteCurrencies();

  Future<bool> removeFavoriteCurrencies();
}
