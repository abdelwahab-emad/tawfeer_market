part of 'user_cubit.dart';

@immutable
sealed class UserState {}

final class UserInitial extends UserState {}

final class UserLoading extends UserState {}

final class UserSuccess extends UserState {
  final List<UserModel> usersList;

  UserSuccess(this.usersList);
}

final class UserError extends UserState {
  final String errorMessage;

  UserError(this.errorMessage);
}