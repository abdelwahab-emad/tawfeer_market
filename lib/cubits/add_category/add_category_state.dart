part of 'add_category_cubit.dart';

@immutable
sealed class AddCategoryState {}

final class AddCategoryInitial extends AddCategoryState {}


final class AddCategoryLoading extends AddCategoryState {}

final class AddCategorySuccess extends AddCategoryState {}

final class AddCategoryFailure extends AddCategoryState {
  final String errMessage;
   AddCategoryFailure({required this.errMessage});
}


final class AddCategoryImagePicked extends AddCategoryState {
  final File image;

  AddCategoryImagePicked({required this.image});

}