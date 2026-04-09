part of 'user_cubit.dart';

@immutable
sealed class UserState {}

final class UserInitial extends UserState {}

final class UserLoading extends UserState {}

final class UserSuccess extends UserState {
  final Map<String, dynamic> userData;
  UserSuccess({required this.userData});
}

final class UserUpdateSuccess extends UserState {}

final class UserFailure extends UserState {
  final String errorMessage;
  UserFailure({required this.errorMessage});
}

final class UserDeleteSuccess extends UserState {}