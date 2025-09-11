import 'package:flutter/material.dart';

class Currency {
  final String symbol;
  final double priceUsd;
  final Color color;

  Currency({
    required this.symbol,
    required this.priceUsd,
    required this.color,
  });
}
