import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/network/requests/assets_request.dart';
import '../../../domain/mappers/currency_ui_model_mapper.dart';
import '../../../domain/models/error_model.dart';
import '../../../domain/ui_models/currencies_ui_model.dart';
import '../../../domain/use_cases/currency_use_case.dart';
import '../../../resources/app_strings.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final CurrencyUseCase _currencyUseCase;
  final CurrencyUiModelMapper _currencyUiModelMapper;

  HomeCubit(this._currencyUseCase, this._currencyUiModelMapper) : super(HomeInitial());

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
        final modelList = currenciesResponse.currencyModelList;
        final uiModelList = _currencyUiModelMapper.uiModelListFromModelList(modelList: modelList);
        _uiModelList.addAll(uiModelList);

        emit(HomeSucceed(currencyUiModelList: _uiModelList, isLastPage: _isLastPage));
      }
    } on ErrorModel catch (e) {
      emit(HomeError(error: e.error ?? AppStrings.noErrorMessage));
    }
  }

  // Future<bool> saveFavoriteCurrencies() async {
  //   final list = _currencyUiModelMapper.modelListFromUiModelList(uiModelList: _uiModelList);
  //   final isSaved = await _currencyUseCase.saveFavoritesCurrencies(list: list);
  //   final modelList = _currencyUseCase.loadFavoriteCurrencies();
  //   final isRemoved = await _currencyUseCase.removeFavoriteCurrenciesList();
  //   return isSaved;
  // }
}
