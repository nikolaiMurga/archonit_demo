import 'package:flutter/material.dart';

import '../models/currency_model.dart';

class CurrencyUiCardModel {
  final CurrencyModel currencyModel;
  final Color color;

  CurrencyUiCardModel({
    required this.currencyModel,
    required this.color,
  });
}
