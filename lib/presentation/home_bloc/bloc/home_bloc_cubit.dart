import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/network/requests/assets_request.dart';
import '../../../domain/mixins/random_color_mixin.dart';
import '../../../domain/models/currency_model.dart';
import '../../../domain/models/error_model.dart';
import '../../../domain/ui_models/currencies_ui_card_model.dart';
import '../../../domain/use_cases/currency_use_case.dart';

part 'home_bloc_state.dart';

class HomeBlocCubit extends Cubit<HomeBlocState> with RandomColorMixin {
  final CurrencyUseCase _currencyUseCase;

  HomeBlocCubit(this._currencyUseCase) : super(HomeBlocInitial());

  final List<CurrencyUiCardModel> _uiModelList = [];
  bool _isLastPage = false;
  int _nextPage = 0;

  void _clear() {
    _uiModelList.clear();
    _isLastPage = false;
    _nextPage = 0;
  }

  Future<void> getCurrenciesList() async {
    try{
      final request = AssetsRequest(page: _nextPage);
      final modelList = await _currencyUseCase.fetchCurrenciesList(request: request);

      if (modelList.isNotEmpty) {
        emit(HomeBlocEmpty());
      } else {
        // todo api should respond total pages to implement stop loading ui behavior
        // _isLastPage = pUiModel.page == pUiModel.totalPages;
        // if (!_isLastPage) _nextPage = pUiModel.page + 1;
        if (!_isLastPage) _nextPage += 1;

        for (CurrencyModel model in modelList) {
          final color = generateRandomColor();
          final uiModel = CurrencyUiCardModel(currencyModel: model, color: color);
          _uiModelList.add(uiModel);
        }
        emit(HomeBlocSucceed(currencyUiModelList: _uiModelList, isLastPage: _isLastPage));
      }
    } on ErrorModel catch (e){
      emit(HomeBlocError());
    }
  }
}
