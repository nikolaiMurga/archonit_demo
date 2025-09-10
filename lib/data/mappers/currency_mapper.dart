import 'package:flutter/material.dart';
import '../network/dto/currency_dto.dart';
import '../../domain/mixins/random_color_mixin.dart';
import '../../domain/models/currency.dart';

class CurrencyMapper with RandomColorMixin {
  Currency fromDto(CurrencyDto dto) {
    final color = generateRandomColor();
    return Currency(
      symbol: dto.symbol ?? 'symbol',
      priceUsd: double.parse(dto.priceUsd ?? '0.00'),
      color: color,
    );
  }

  Currency fromJson(Map<String, dynamic> json) {
    final hexCode = json['color'].replaceAll('#', '');
    final color = Color(int.parse(hexCode, radix: 16));

    return Currency(
      symbol: json['symbol'],
      priceUsd: json['priceUsd'],
      color: color,
    );
  }

  Map<String, dynamic> toJson(Currency model) {
    return {
      'symbol': model.symbol,
      'priceUsd': model.priceUsd,
      'color': '#${model.color.value.toRadixString(16).padLeft(8, '0')}',
    };
  }
}
