import '../../../domain/models/currency_model.dart';

class CurrenciesResponse {
  final List<CurrencyModel> currencyModelList;
  final int totalPages;

  CurrenciesResponse({required this.currencyModelList, required this.totalPages});

  factory CurrenciesResponse.fromJson(Map<String, dynamic> json) {
    return CurrenciesResponse(
      currencyModelList: json['data'] == null ? [] : List<CurrencyModel>.from(json['data']!.map((j) => CurrencyModel.fromJson(j))),
      totalPages: json['total_pages'] ?? 3, // mock total pages. should be in response for last page logic
    );
  }
}
