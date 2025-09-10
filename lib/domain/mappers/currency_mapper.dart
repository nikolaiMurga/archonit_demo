import 'package:flutter/material.dart';
import '../../data/network/dto/currency_dto.dart';
import '../mixins/random_color_mixin.dart';
import '../models/currency.dart';

class CurrencyMapper with RandomColorMixin {
  Currency fromDto(CurrencyDto dto) {
    final color = generateRandomColor();
    return Currency(
      symbol: dto.symbol ?? 'symbol',
      priceUsd: double.parse(dto.priceUsd ?? '0.00'),
      color: color,
    );
  }

  CurrencyModel fromJson(Map<String, dynamic> json) {
    final hexCode = json['color'].replaceAll('#', '');
    final color = Color(int.parse(hexCode, radix: 16));

    return CurrencyModel(
      symbol: json['symbol'],
      priceUsd: json['priceUsd'],
      color: color,
    );
  }

  Map<String, dynamic> toJson(CurrencyModel model) {
    return {
      'symbol': model.symbol,
      'priceUsd': model.priceUsd,
      'color': '#${model.color.value.toRadixString(16).padLeft(8, '0')}',
    };
  }
}
