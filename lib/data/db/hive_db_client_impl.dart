import 'package:hive/hive.dart';

import '../../app/logging_service.dart';
import 'db_client.dart';
import 'persistence_helper.dart';

class HiveDbClientImpl implements DbClient {
  final _favoritesCurrenciesKey = 'favorites_currencies_key';

  @override
  String? loadFavoriteCurrencies() {
    // TODO: implement loadFavoriteCurrenciesList
    throw UnimplementedError();
  }

  @override
  Future<bool> removeFavoriteCurrencies() {
    // TODO: implement removeFavoriteCurrenciesList
    throw UnimplementedError();
  }

  @override
  Future<bool> saveFavoriteCurrencies(String jsonString) async {
    await Hive.box(HiveBoxes.favoriteCurrenciesBox).put(_favoritesCurrenciesKey, jsonString);
    LogService.addLog('saveFavoriteCurrenciesList succeed is true');
    return true;
  }
}
