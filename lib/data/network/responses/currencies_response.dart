import 'package:archonit_demo/data/network/dto/currency_dto.dart';

class CurrenciesResponse {
  final List<CurrencyDto> dtoList;
  final int totalPages;

  CurrenciesResponse({required this.dtoList, required this.totalPages});

  factory CurrenciesResponse.fromJson(Map<String, dynamic> json) {
    return CurrenciesResponse(
      dtoList: json['data'] == null ? [] : List<CurrencyDto>.from(json['data']!.map((j) => CurrencyDto.fromJson(j))),
      totalPages: json['total_pages'] ?? 3, // mock total pages. should be in response for last page logic
    );
  }
}
