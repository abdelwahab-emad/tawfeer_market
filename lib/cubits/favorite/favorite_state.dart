part of 'favorite_cubit.dart';

@immutable
sealed class FavoriteState {}

final class FavoriteInitial extends FavoriteState {}

final class FavoriteLoading extends FavoriteState {}

final class FavoriteSuccess extends FavoriteState {
  final List<ProductModel> products;
  FavoriteSuccess({required this.products});
}

final class FavoriteFailure extends FavoriteState {
  final String errorMessage;
  FavoriteFailure({required this.errorMessage});
}