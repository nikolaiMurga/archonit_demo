import 'dart:convert';

import 'package:archonit_demo/data/db/db_client.dart';
import 'package:archonit_demo/domain/mappers/currency_mapper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app/logging_service.dart';
import '../../domain/models/currency_model.dart';

class SharedDbClientImpl implements DbClient {
  final SharedPreferences _pref;
  final CurrencyMapper _mapper;

  SharedDbClientImpl(this._pref, this._mapper);

  // clear storage
  Future<bool> clearStorage() async {
    final isClear = await _pref.clear();
    return isClear;
  }

  //  Favorite Currencies List
  final _favoriteCurrenciesKey = 'favorite_currencies_key';

  Map<String, dynamic> _currModelListToJson(list) {
    return {'list' : list.map((m) => _mapper.toJson(m)).toList()};
  }

  @override
  Future<bool> saveFavoriteCurrenciesList(List<CurrencyModel> list) async {
    final json = _currModelListToJson(list);
    final jsonString = jsonEncode(json);
    final isSet = await _pref.setString(_favoriteCurrenciesKey, jsonString);
    LogService.addLog('saveFavoriteCurrenciesList succeed is $isSet');
    return isSet;
  }

  List<CurrencyModel> _currModelListFromJson(json) {
    return List<CurrencyModel>.from(json['list']!.map((j) => _mapper.fromJson(j)));
  }

  @override
  List<CurrencyModel> loadFavoriteCurrenciesList() {
    final jsonString = _pref.getString(_favoriteCurrenciesKey);
    LogService.addLog('loadFavoriteCurrenciesList succeed');
    if (jsonString != null) {
      final json = jsonDecode(jsonString);
      final list = _currModelListFromJson(json);
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
