import 'package:tawfeer_market/models/order_model.dart';

abstract class OrdersState {}

class OrdersInitial extends OrdersState {}

class OrdersLoading extends OrdersState {}

class OrdersSuccess extends OrdersState {
  final List<OrderModel> orders;
  OrdersSuccess({required this.orders});
}

class OrdersFailure extends OrdersState {
  final String errorMessage;
  OrdersFailure({required this.errorMessage});
}

class OrderDetailsSuccess extends OrdersState {
  final OrderModel order;
  OrderDetailsSuccess({required this.order});
}