import 'dart:convert';

import '../../domain/mappers/currency_mapper.dart';
import '../../domain/models/currency_model.dart';
import '../db/db_client.dart';

class LocalRepo {
  final DbClient _dbClient;
  final CurrencyMapper _currencyMapper;

  LocalRepo(this._dbClient, this._currencyMapper);

  Future<bool> saveFavoriteCurrencies({required List<CurrencyModel> list}) async {
    final json = {'list': list.map((m) => _currencyMapper.toJson(m)).toList()};
    final jsonString = jsonEncode(json);
    return await _dbClient.saveFavoriteCurrencies(jsonString);
  }

  List<CurrencyModel> loadFavoriteCurrencies() {
    final jsonString = _dbClient.loadFavoriteCurrencies();
    if (jsonString != null) {
      final json = jsonDecode(jsonString);
      final list = List<CurrencyModel>.from(json['list']!.map((j) => _currencyMapper.fromJson(j)));
      return list;
    }
    return [];
  }

  Future<bool> removeFavoriteCurrencies() async {
    return await _dbClient.removeFavoriteCurrencies();
  }
}
