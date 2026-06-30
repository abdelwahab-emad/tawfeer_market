part of 'order_details_cubit.dart';

abstract class OrderDetailsState {}

class OrderDetailsInitial extends OrderDetailsState {}

class OrderDetailsLoading extends OrderDetailsState {}

class OrderDetailsSuccess extends OrderDetailsState {
  final OrderModel order;

  OrderDetailsSuccess({required this.order});
}

class OrderDetailsFailure extends OrderDetailsState {
  final String errorMessage;

  OrderDetailsFailure({required this.errorMessage});
}