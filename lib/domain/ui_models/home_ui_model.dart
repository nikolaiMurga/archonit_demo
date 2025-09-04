import 'package:archonit_demo/domain/models/currency_model.dart';

import 'currencies_ui_card_model.dart';

class HomeUiModel {
  final List<CurrencyModel> currencyModelList;
  final int totalPages;

  HomeUiModel({required this.currencyModelList, this.totalPages = 3});
}
