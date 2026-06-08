import 'dart:convert';

import 'package:archonit_demo/data/db/db_client.dart';
import 'package:archonit_demo/data/mappers/currency_mapper.dart';
import 'package:archonit_demo/domain/models/currency.dart';
import 'package:archonit_demo/domain/repos/local_repo.dart';

class LocalRepoImpl implements LocalRepo {
  final DbClient _dbClient;
  final CurrencyMapper _currencyMapper;

  LocalRepoImpl(this._dbClient, this._currencyMapper);

  @override
  Future<bool> saveFavoriteCurrencies({required List<Currency> list}) async {
    final json = {'list': list.map((m) => _currencyMapper.toJson(m)).toList()};
    final jsonString = jsonEncode(json);
    return _dbClient.saveFavoriteCurrencies(jsonString);
  }

  @override
  List<Currency> loadFavoriteCurrencies() {
    final jsonString = _dbClient.loadFavoriteCurrencies();
    if (jsonString != null) {
      final json = jsonDecode(jsonString);
      final list = List<Currency>.from(json['list']!.map((j) => _currencyMapper.fromJson(j)));
      return list;
    }
    return [];
  }

  @override
  Future<bool> removeFavoriteCurrencies() async {
    return _dbClient.removeFavoriteCurrencies();
  }
}
