import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/models/currency.dart';
import '../../../domain/models/error_model.dart';
import '../../../domain/use_cases/favorites_use_case.dart';

part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  final FavoritesUseCase _favoritesUseCase;

  FavoritesCubit(this._favoritesUseCase) : super(const FavoritesState(favoritesList: [])) {
    loadFavoritesCurrenciesList();
  }

  void loadFavoritesCurrenciesList() {
    emit(FavoritesState(isLoading: true, favoritesList: state.favoritesList));
    final loadedList = _favoritesUseCase.loadFavoriteCurrencies();
    emit(FavoritesState(favoritesList: loadedList));
  }

  Future<void> updateFavoriteCurrencies({required Currency currency}) async {
    // check if model is in favorites
    final isModelInFavorites = state.favoritesList.contains(currency);
    if (isModelInFavorites) {
      // if model is in favorites remove model
      final updatedList = state.favoritesList.where((curr) => curr != currency).toList();
      // cache updated list without model
      await _favoritesUseCase.saveFavoritesCurrencies(list: updatedList);
      // update state
      emit(FavoritesState(favoritesList: updatedList));
    } else {
      // if no, save model to favorites
      final updatedList = [...state.favoritesList, currency];
      try {
        // cached favorites list
        await _favoritesUseCase.saveFavoritesCurrencies(list: state.favoritesList);
        emit(FavoritesState(favoritesList: updatedList));
      } catch (e) {
        emit(
          FavoritesState(
            favoritesList: state.favoritesList,
            error: ErrorModel(message: e.toString()),
          ),
        );
      }
    }
  }

  bool isFavorite(Currency curr) => state.favoritesList.contains(curr);
}
