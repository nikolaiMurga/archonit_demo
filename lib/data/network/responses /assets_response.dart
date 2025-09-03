import '../dtos/currency_dto.dart';

class AssetsResponse {
  List<CurrencyDto>? currencyDtoList;

  AssetsResponse({this.currencyDtoList});

  factory AssetsResponse.fromJson(Map<String, dynamic> json) => AssetsResponse(
        currencyDtoList: json['data'] == null ? [] : List<CurrencyDto>.from(json['data']!.map((j) => CurrencyDto.fromJson(j))),
      );
}
