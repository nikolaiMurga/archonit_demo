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

  Future<void> getCurrencies({bool isScroll = false}) async {
    if (_isLastPage) return;

    if (!isScroll) {
      emit(HomeBlocLoading());
      _clear();
    } else {
      emit(HomeBlocScroll());
    }
    fetchCurrencyUiCardModelList();
  }

  Future<void> fetchCurrencyUiCardModelList() async {
    try {
      final request = AssetsRequest(page: _nextPage);
      final homeUiModel = await _currencyUseCase.fetchCurrenciesList(request: request);

      if (homeUiModel.currencyModelList.isEmpty) {
        emit(HomeBlocEmpty());
      } else {
        _isLastPage = _nextPage == homeUiModel.totalPages;
        if (!_isLastPage) _nextPage += 1;

        for (CurrencyModel model in homeUiModel.currencyModelList) {
          final color = generateRandomColor();
          final uiModel = CurrencyUiCardModel(currencyModel: model, color: color);
          _uiModelList.add(uiModel);
        }
        emit(HomeBlocSucceed(currencyUiModelList: _uiModelList, isLastPage: _isLastPage));
      }
    } on ErrorModel catch (e) {
      emit(HomeBlocError());
    }
  }
}
