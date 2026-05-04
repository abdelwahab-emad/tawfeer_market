part of 'product_cubit.dart';

@immutable
sealed class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductSuccess extends ProductState {
  final List<ProductModel> products;
  ProductSuccess(this.products);
}

class ProductError extends ProductState {
  final String message;
  ProductError(this.message);
}

class ProductDeleteLoading extends ProductState {}

class ProductDeleteSuccess extends ProductState {}

class ProductDeleteError extends ProductState {
  final String message;
  ProductDeleteError(this.message);
}