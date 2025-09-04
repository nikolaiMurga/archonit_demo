part of 'home_bloc_cubit.dart';

sealed class HomeBlocState extends Equatable {
  const HomeBlocState();
}

final class HomeBlocInitial extends HomeBlocState {
  @override
  List<Object> get props => [];
}

final class HomeBlocLoading extends HomeBlocState {
  @override
  List<Object> get props => [];
}

final class HomeBlocSucceed extends HomeBlocState {
  final List<CurrencyUiCardModel> currencyUiModelList;
  final bool isLastPage;

  const HomeBlocSucceed({required this.currencyUiModelList, required this.isLastPage});

  @override
  List<Object> get props => [currencyUiModelList, isLastPage];
}

final class HomeBlocError extends HomeBlocState {
  @override
  List<Object> get props => [];
}

final class HomeBlocEmpty extends HomeBlocState {
  @override
  List<Object> get props => [];
}
