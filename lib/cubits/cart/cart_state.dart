part of 'cart_cubit.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}

final class CartLoading extends CartState {}

final class CartSuccess extends CartState {
  final List<ProductModel> products;
  CartSuccess({required this.products});
}

final class CartFailure extends CartState {
  final String errorMessage;
  CartFailure({required this.errorMessage});
}
