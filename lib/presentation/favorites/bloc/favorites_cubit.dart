import 'package:archonit_demo/domain/models/currency.dart';
import 'package:archonit_demo/domain/models/error_model.dart';
import 'package:archonit_demo/domain/use_cases/favorites_use_case.dart';
import 'package:archonit_demo/presentation/home/bloc/home_cubit.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  final FavoritesUseCase _favoritesUseCase;

  FavoritesCubit(this._favoritesUseCase) : super(FavoritesState(favoritesList: [])) {
    loadFavoritesCurrenciesList();
  }

  void loadFavoritesCurrenciesList() {
    emit(FavoritesState(isLoading: true, favoritesList: state.favoritesList));
    final loadedList = _favoritesUseCase.loadFavoriteCurrencies();
    emit(FavoritesState(favoritesList: loadedList));
  }

  Future<void> updateFavoriteCurrencies({required Currency model}) async {
    // check if model is in favorites
    final isModelInFavorites = state.favoritesList.contains(model);
    if (isModelInFavorites) {
      // if model is in favorites remove model
      final updatedList = state.favoritesList.where((curr) => curr != model).toList();
      // cache updated list without model
      await _favoritesUseCase.saveFavoritesCurrencies(list: updatedList);
      // update state
      emit(FavoritesState(favoritesList: updatedList));
    } else {
      // if no, save model to favorites
      state.favoritesList.add(model);
      try {
        // cached favorites list
        await _favoritesUseCase.saveFavoritesCurrencies(list: state.favoritesList);
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
