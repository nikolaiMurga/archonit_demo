import '../models/currency_model.dart';

class HomeUiModel {
  final List<CurrencyModel> currencyModelList;
  final int totalPages;

  HomeUiModel({required this.currencyModelList, this.totalPages = 3});
}
