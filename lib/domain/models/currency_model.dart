import 'package:flutter/material.dart';

class CurrencyModel {
  final String symbol;
  final String priceUsd;
  final Color color;

  CurrencyModel({
    required this.symbol,
    required this.priceUsd,
    required this.color,
  });

  factory CurrencyModel.fromJson(Map<String, dynamic> json) {
    final hexCode = json['color'].replaceAll('#', '');
    final color = Color(int.parse(hexCode, radix: 16));

    return CurrencyModel(
      symbol: json['symbol'],
      priceUsd: json['priceUsd'],
      color: color,
    );
  }

  Map<String, dynamic> toJson() => {
        'symbol': symbol,
        'priceUsd': priceUsd,
        'color': '#${color.value.toRadixString(16).padLeft(8, '0')}',
      };
}
