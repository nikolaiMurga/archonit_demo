import 'package:hive/hive.dart';

import '../../app/logging_service.dart';
import 'db_client.dart';
import 'persistence_helper.dart';

class HiveDbClientImpl implements DbClient {
  final _favoritesCurrenciesKey = 'favorites_currencies_key';

  @override
  Future<String?> loadFavoriteCurrencies() async {
    final jsonString = await Hive.box(HiveBoxes.favoriteCurrenciesBox).get(_favoritesCurrenciesKey);
    return jsonString;
  }

  @override
  Future<bool> removeFavoriteCurrencies() async {
    await Hive.box(HiveBoxes.favoriteCurrenciesBox).delete(_favoritesCurrenciesKey);
    return true;
  }

  @override
  Future<bool> saveFavoriteCurrencies(String jsonString) async {
    await Hive.box(HiveBoxes.favoriteCurrenciesBox).put(_favoritesCurrenciesKey, jsonString);
    LogService.addLog('saveFavoriteCurrenciesList succeed is true');
    return true;
  }
}
