import 'package:archonit_demo/domain/models/currency_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/network/requests/assets_request.dart';
import '../../../domain/models/error_model.dart';
import '../../../domain/use_cases/currency_use_case.dart';
import '../../../resources/app_strings.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final CurrencyUseCase _currencyUseCase;

  HomeCubit(this._currencyUseCase) : super(HomeInitial());

  final List<CurrencyModel> _currenciesList = [];
  bool _isLastPage = false;
  int _nextPage = 0;

  void _clear() {
    _currenciesList.clear();
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
    _fetchCurrencyUiModelList();
  }

  Future<void> _fetchCurrencyUiModelList() async {
    try {
      final request = CurrenciesRequest(page: _nextPage);
      final uiModel = await _currencyUseCase.fetchCurrencies(request: request);

      if (uiModel.currenciesList.isEmpty) {
        emit(HomeEmpty());
      } else {
        _isLastPage = _nextPage == uiModel.totalPages;
        if (!_isLastPage) _nextPage += 1;
        _currenciesList.addAll(uiModel.currenciesList);

        emit(HomeSucceed(currenciesList: _currenciesList, isLastPage: _isLastPage));
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
