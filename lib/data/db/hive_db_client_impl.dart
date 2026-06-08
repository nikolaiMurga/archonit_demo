import '../../core/logging_service.dart';
import 'db_client.dart';
import 'hive_persistence_service.dart';

class HiveDbClientImpl implements DbClient {
  final _favoritesCurrenciesKey = 'favorites_currencies_key';

  @override
  Future<bool> saveFavoriteCurrencies(String jsonString) async {
    await HivePersistenceService.instance.favoriteCurrenciesBox.put(_favoritesCurrenciesKey, jsonString);
    LogService.printLog('saveFavoriteCurrenciesList succeed is true');
    return true;
  }

  @override
  String? loadFavoriteCurrencies() {
    final jsonString = HivePersistenceService.instance.favoriteCurrenciesBox.get(_favoritesCurrenciesKey);
    LogService.printLog('loadFavoriteCurrencies succeed, found: ${jsonString != null}');
    return jsonString;
  }

  @override
  Future<bool> removeFavoriteCurrencies() async {
    await HivePersistenceService.instance.favoriteCurrenciesBox.delete(_favoritesCurrenciesKey);
    LogService.printLog('removeFavoriteCurrencies succeed');
    return true;
  }
}
