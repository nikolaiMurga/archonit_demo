import 'dart:convert';

import 'package:archonit_demo/data/db/db_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app/logging_service.dart';
import '../../domain/models/currency_model.dart';

class SharedDbClientImpl implements DbClient{
  final SharedPreferences _pref;

  SharedDbClientImpl(this._pref);

  // clear storage
  Future<bool> clearStorage() async {
    final isClear = await _pref.clear();
    return isClear;
  }

  //  Favorite Currencies List
  final _favoriteCurrenciesKey = 'favorite_currencies_key';

  Map<String, dynamic> _listToJson(list) => {"list": List<CurrencyModel>.from(list.map((x) => x))};

  @override
  Future<bool> saveFavoriteCurrenciesList(List<CurrencyModel> list) async {
    final json = _listToJson(list);
    final jsonString = jsonEncode(json);
    final isSet = await _pref.setString(_favoriteCurrenciesKey, jsonString);
    LogService.addLog('saveFavoriteCurrenciesList succeed is $isSet');
    return isSet;
  }

  List<CurrencyModel> _listFromJson(json) => List<CurrencyModel>.from(json.map((x) => x));

  @override
  List<CurrencyModel> loadFavoriteCurrenciesList() {
    final jsonString = _pref.getString(_favoriteCurrenciesKey);
    LogService.addLog('loadFavoriteCurrenciesList succeed $jsonString');
    if (jsonString != null) {
      final json = jsonDecode(jsonString);
      final list = _listFromJson(json);
      return list;
    }
    return [];
  }

  @override
  Future<bool> removeFavoriteCurrenciesList() async {
    final isDeleted = await _pref.remove(_favoriteCurrenciesKey);
    return isDeleted;
  }
}
