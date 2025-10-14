import 'package:flutter/material.dart';

class Currency {
  final String id;
  final String symbol;
  final double priceUsd;
  final Color color;

  Currency({required this.id, required this.symbol, required this.priceUsd, required this.color});

  @override
  int get hashCode => id.hashCode;

  @override
  bool operator ==(Object other) => other is Currency && id == other.id && symbol == other.symbol;
}
