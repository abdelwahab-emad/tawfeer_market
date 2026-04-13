part of 'admin_nav_cubit.dart';

@immutable
abstract class AdminNavState {}

class AdminNavInitial extends AdminNavState {}

class AdminNavUpdated extends AdminNavState {
  final int index;
  AdminNavUpdated({required this.index});
}