import 'package:archonit_demo/domain/models/currency_model.dart';
import 'package:flutter/material.dart';

class CurrencyUiCardModel {
  final CurrencyModel currencyModel;
  final Color color;

  CurrencyUiCardModel({
    required this.currencyModel,
    required this.color,
  });
}
