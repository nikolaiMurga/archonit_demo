import 'package:archonit_demo/resources/app_strings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/network/requests/assets_request.dart';
import '../../../domain/mixins/random_color_mixin.dart';
import '../../../domain/models/currency_model.dart';
import '../../../domain/models/error_model.dart';
import '../../../domain/ui_models/currencies_ui_model.dart';
import '../../../domain/use_cases/currency_use_case.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> with RandomColorMixin {
  final CurrencyUseCase _currencyUseCase;

  HomeCubit(this._currencyUseCase) : super(HomeInitial());

  final List<CurrencyUiModel> _uiModelList = [];
  bool _isLastPage = false;
  int _nextPage = 0;

  void _clear() {
    _uiModelList.clear();
    _isLastPage = false;
    _nextPage = 0;
  }

  Future<void> getCurrencies({bool isReload = false, bool isScroll = false}) async {
    if (_isLastPage && !isReload) return;

    if (!isScroll) {
      emit(HomeLoading());
      _clear();
    } else {
      emit(HomeScroll());
    }
    fetchCurrencyUiModelList();
  }

  Future<void> fetchCurrencyUiModelList() async {
    try {
      final request = CurrenciesRequest(page: _nextPage);
      final currenciesResponse = await _currencyUseCase.fetchCurrencies(request: request);

      if (currenciesResponse.currencyModelList.isEmpty) {
        emit(HomeEmpty());
      } else {
        _isLastPage = _nextPage == currenciesResponse.totalPages;
        if (!_isLastPage) _nextPage += 1;

        for (CurrencyModel model in currenciesResponse.currencyModelList) {
          final color = generateRandomColor();
          final uiModel = CurrencyUiModel(currencyModel: model, color: color);
          _uiModelList.add(uiModel);
        }
        emit(HomeSucceed(currencyUiModelList: _uiModelList, isLastPage: _isLastPage));
      }
    } on ErrorModel catch (e) {
      emit(HomeError(error: e.error ?? AppStrings.noErrorMessage));
    }
  }
}
