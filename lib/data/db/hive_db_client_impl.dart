import 'package:archonit_demo/app/logging_service.dart';
import 'package:archonit_demo/data/db/db_client.dart';
import 'package:archonit_demo/data/db/hive_persistence_service.dart';

class HiveDbClientImpl implements DbClient {
  final _favoritesCurrenciesKey = 'favorites_currencies_key';

  @override
  Future<bool> saveFavoriteCurrencies(String jsonString) async {
    await HivePersistenceService.instance.favoriteCurrenciesBox.put(_favoritesCurrenciesKey, jsonString);
    LogService.addLog('saveFavoriteCurrenciesList succeed is true');
    return true;
  }

  @override
  String? loadFavoriteCurrencies() {
    final jsonString = HivePersistenceService.instance.favoriteCurrenciesBox.get(_favoritesCurrenciesKey);
    return jsonString;
  }

  @override
  Future<bool> removeFavoriteCurrencies() async {
    await HivePersistenceService.instance.favoriteCurrenciesBox.delete(_favoritesCurrenciesKey);
    return true;
  }
}
