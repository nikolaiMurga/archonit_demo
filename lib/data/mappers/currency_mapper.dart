import 'package:archonit_demo/data/network/dto/currency_dto.dart';
import 'package:archonit_demo/domain/mixins/random_color_mixin.dart';
import 'package:archonit_demo/domain/models/currency.dart';
import 'package:flutter/material.dart';

class CurrencyMapper with RandomColorMixin {
  Currency fromDto(CurrencyDto dto) {
    final color = generateRandomColor();
    return Currency(id: dto.id ?? 'id', symbol: dto.symbol ?? 'symbol', priceUsd: double.parse(dto.priceUsd ?? '0.00'), color: color);
  }

  Currency fromJson(Map<String, dynamic> json) {
    final hexCode = json['color'].replaceAll('#', '');
    final color = Color(int.parse(hexCode, radix: 16));

    return Currency(id: json['id'], symbol: json['symbol'], priceUsd: json['priceUsd'], color: color);
  }

  Map<String, dynamic> toJson(Currency model) {
    return {
      'id': model.id,
      'symbol': model.symbol,
      'priceUsd': model.priceUsd,
      'color': '#${model.color.value.toRadixString(16).padLeft(8, '0')}',
    };
  }
}
