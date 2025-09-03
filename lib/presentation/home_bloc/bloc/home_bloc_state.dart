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
  @override
  List<Object> get props => [];
}

final class HomeBlocError extends HomeBlocState {
  @override
  List<Object> get props => [];
}
