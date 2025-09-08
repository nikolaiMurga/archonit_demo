import '../mixins/random_color_mixin.dart';
import '../models/currency_model.dart';
import '../ui_models/currencies_ui_model.dart';

class CurrencyUiModelMapper with RandomColorMixin {
  CurrencyUiModel uiModelFromModel({required CurrencyModel model}) {
    final color = generateRandomColor();
    final uiModel = CurrencyUiModel(currencyModel: model, color: color);
    return uiModel;
  }

  CurrencyModel modelFromUiModel({required CurrencyUiModel uiModel}) {
    final model = uiModel.currencyModel;
    return model;
  }

  List<CurrencyUiModel> uiModelListFromModelList({required List<CurrencyModel> modelList}) {
    final uiModelList = <CurrencyUiModel>[];

    for (CurrencyModel model in modelList) {
      final uiModel = uiModelFromModel(model: model);
      uiModelList.add(uiModel);
    }
    return uiModelList;
  }

  List<CurrencyModel> modelListFromUiModelList({required List<CurrencyUiModel> uiModelList}) {
    final modelList = <CurrencyModel>[];

    for (CurrencyUiModel uiModel in uiModelList) {
      modelList.add(uiModel.currencyModel);
    }
    return modelList;
  }
}
