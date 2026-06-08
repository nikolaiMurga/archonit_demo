import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/models/currency.dart';
import '../../../domain/models/error_model.dart';
import '../../../domain/use_cases/favorites_use_case.dart';

part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  final FavoritesUseCase _favoritesUseCase;
  StreamSubscription<List<Currency>>? _favoritesSubscription;

  FavoritesCubit(this._favoritesUseCase) : super(const FavoritesState(favoritesList: [])) {
    _subscribeToFavorites();
  }

  void _subscribeToFavorites() {
    emit(FavoritesState(isLoading: true, favoritesList: [...state.favoritesList]));

    _favoritesSubscription = _favoritesUseCase.favoritesStream.listen(
          (updatedList) {
        emit(FavoritesState(favoritesList: [...updatedList]));
      },
      onError: (e) {
        emit(FavoritesState(favoritesList: state.favoritesList, error: ErrorModel(message: e.toString())));
      },
    );

    final initialList = _favoritesUseCase.currentFavorites;
    emit(FavoritesState(favoritesList: [...initialList]));
  }

  Future<void> updateFavoriteCurrencies({required Currency currency}) async {
    try {
      await _favoritesUseCase.toggleFavorite(currency);
    } catch (e) {
      emit(FavoritesState(
        favoritesList: state.favoritesList,
        error: ErrorModel(message: e.toString()),
      ));
    }
  }

  @override
  Future<void> close() {
    _favoritesSubscription?.cancel();
    return super.close();
  }
}