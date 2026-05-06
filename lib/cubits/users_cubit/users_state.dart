part of 'users_cubit.dart';

@immutable
sealed class UsersState {}

final class UserInitial extends UsersState {}

final class UserLoading extends UsersState {}

final class UserSuccess extends UsersState {
  final List<UserModel> usersList;

  UserSuccess(this.usersList);
}

final class UserError extends UsersState {
  final String errorMessage;

  UserError(this.errorMessage);
}