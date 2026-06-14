import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:tawfeer_market/models/order_model.dart';

part 'admin_orders_state.dart';

class AdminOrdersCubit extends Cubit<AdminOrdersState> {
  AdminOrdersCubit() : super(AdminOrdersInitial());

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  StreamSubscription? _ordersSubscription;
  Future<void> getOrders() async {
    emit(AdminOrdersLoading());
    _ordersSubscription?.cancel();
    try {
      _ordersSubscription = _firestore
          .collection('orders')
          .orderBy('orderDate', descending: true)
          .snapshots()
          .listen((querySnapshot) {
            List<OrderModel> orders = [];
            for (var doc in querySnapshot.docs) {
              var data = doc.data();
              orders.add(
                OrderModel(
                  orderId: data['orderId'],
                  items: [],
                  totalPrice: (data['totalPrice'] as num).toDouble(),
                  orderDate: DateTime.parse(data['orderDate']),
                  status: data['status'] ?? 'pending',
                ),
              );
            }
            emit(AdminOrdersSuccess(orders: orders));
          }, onError: (error) {
            emit(AdminOrdersFailure(error.toString()));
          });
    } catch (e) {
      emit(AdminOrdersFailure(e.toString()));
    }
  }
}
