part of 'category_cubit.dart';

@immutable
sealed class CategoryState {}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategorySuccess extends CategoryState {
  final List<CategoryModel> categoriesList;
  CategorySuccess(this.categoriesList);
}


class CategoryError extends CategoryState {
  final String message;
  CategoryError(this.message);
}


class CategoryDeleteLoading extends CategoryState {}

class CategoryDeleteSuccess extends CategoryState {}

class CategoryDeleteError extends CategoryState {
  final String message;
  CategoryDeleteError(this.message);
}