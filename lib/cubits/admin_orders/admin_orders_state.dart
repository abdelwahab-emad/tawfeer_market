part of 'admin_orders_cubit.dart';

@immutable
sealed class AdminOrdersState {}

final class AdminOrdersInitial extends AdminOrdersState {}

final class AdminOrdersLoading extends AdminOrdersState {}

final class AdminOrdersSuccess extends AdminOrdersState {
  final List<OrderModel> orders;
  final int totalCount;
  final int pendingCount;
  final int deliveredCount;
  final int cancelledCount;

  AdminOrdersSuccess({
    required this.orders,
    required this.totalCount,
    required this.pendingCount,
    required this.deliveredCount,
    required this.cancelledCount,
  });
}

final class AdminOrdersFailure extends AdminOrdersState {
  final String error;

  AdminOrdersFailure(this.error);
}
