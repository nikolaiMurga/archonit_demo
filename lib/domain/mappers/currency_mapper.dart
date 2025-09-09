import '../../data/network/dtos/currency_dto.dart';
import '../mixins/random_color_mixin.dart';
import '../models/currency_model.dart';

class CurrencyMapper with RandomColorMixin {
  CurrencyModel _fromDto(CurrencyDto dto) {
    final color = generateRandomColor();
    return CurrencyModel(
      symbol: dto.symbol ?? 'symbol',
      priceUsd: dto.priceUsd ?? '0.00',
      color: color,
    );
  }

  List<CurrencyModel> fromDtoList(List<CurrencyDto> dtoList) {
    final list = <CurrencyModel>[];
    if (dtoList.isNotEmpty) {
      for (CurrencyDto dto in dtoList) {
        list.add(_fromDto(dto));
      }
    }
    return list;
  }
}
