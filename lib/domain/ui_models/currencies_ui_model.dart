import '../models/currency_model.dart';

class CurrencyUiModel {
  final List<CurrencyModel> currenciesList;
  final int totalPages;

  CurrencyUiModel({
    required this.currenciesList,
    required this.totalPages,
  });
}
