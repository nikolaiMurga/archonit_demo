import 'currency.dart';

class PaginatedCurrencies {
  final List<Currency> currenciesList;
  final int totalPages;

  PaginatedCurrencies({
    required this.currenciesList,
    required this.totalPages,
  });
}
