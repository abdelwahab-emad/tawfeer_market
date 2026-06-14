part of 'admin_orders_cubit.dart';

@immutable
sealed class AdminOrdersState {}

final class AdminOrdersInitial extends AdminOrdersState {}


final class AdminOrdersLoading extends AdminOrdersState {}

final class AdminOrdersSuccess extends AdminOrdersState {
  final List<OrderModel> orders;

  AdminOrdersSuccess({required this.orders});
}

final class AdminOrdersFailure extends AdminOrdersState {
  final String error;

  AdminOrdersFailure(this.error);
}