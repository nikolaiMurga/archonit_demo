import 'package:shared_preferences/shared_preferences.dart';

import '../../app/logging_service.dart';
import 'db_client.dart';

class SharedDbClientImpl implements DbClient {
  final SharedPreferences _pref;

  SharedDbClientImpl(this._pref);

  // clear storage
  Future<bool> clearStorage() async {
    final isClear = await _pref.clear();
    return isClear;
  }

  //  save favorite currencies
  final _favoriteCurrenciesKey = 'favorite_currencies_key';

  @override
  Future<bool> saveFavoriteCurrencies(String jsonString) async {
    final isSet = await _pref.setString(_favoriteCurrenciesKey, jsonString);
    LogService.addLog('saveFavoriteCurrenciesList succeed is $isSet');
    return isSet;
  }

  @override
  Future<String?> loadFavoriteCurrencies() async {
    final jsonString = _pref.getString(_favoriteCurrenciesKey);
    LogService.addLog('loadFavoriteCurrenciesList succeed is $jsonString');
    return jsonString;
  }

  @override
  Future<bool> removeFavoriteCurrencies() async {
    final isRemoved = await _pref.remove(_favoriteCurrenciesKey);
    LogService.addLog('removeFavoriteCurrenciesList succeed is $isRemoved');
    return isRemoved;
  }
}
