import 'dart:convert';

import '../mappers/currency_mapper.dart';
import '../../domain/models/currency.dart';
import '../db/db_client.dart';

class LocalRepo {
  final DbClient _dbClient;
  final CurrencyMapper _currencyMapper;

  LocalRepo(this._dbClient, this._currencyMapper);

  Future<bool> saveFavoriteCurrencies({required List<Currency> list}) async {
    final json = {'list': list.map((m) => _currencyMapper.toJson(m)).toList()};
    final jsonString = jsonEncode(json);
    return _dbClient.saveFavoriteCurrencies(jsonString);
  }

  Future<List<Currency>> loadFavoriteCurrencies() async {
    final jsonString = await _dbClient.loadFavoriteCurrencies();
    if (jsonString != null) {
      final json = jsonDecode(jsonString);
      final list = List<Currency>.from(json['list']!.map((j) => _currencyMapper.fromJson(j)));
      return list;
    }
    return [];
  }

  Future<bool> removeFavoriteCurrencies() async {
    return _dbClient.removeFavoriteCurrencies();
  }
}
