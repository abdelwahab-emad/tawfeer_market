import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tawfeer_market/models/order_model.dart';
import 'package:tawfeer_market/cubits/orders/orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit() : super(OrdersInitial());

  void fetchUserOrders() {
    emit(OrdersLoading());
    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;
      FirebaseFirestore.instance
          .collection('orders')
          .where('userId', isEqualTo: userId)
          .orderBy('orderDate', descending: true)
          .snapshots()
          .listen((snapshot) {
        List<OrderModel> ordersList = [];
        for (var doc in snapshot.docs) {
          var data = doc.data();
          ordersList.add(
            OrderModel(
              orderId: data['orderId'],
              items: [],
              totalPrice: (data['totalPrice'] as num).toDouble(),
              orderDate: DateTime.parse(data['orderDate']),
              status: data['status'] ?? 'Pending',
            ),
          );
        }
        emit(OrdersSuccess(orders: ordersList));
      }, onError: (error) {
        emit(OrdersFailure(errorMessage: error.toString()));
      });
    } catch (e) {
      emit(OrdersFailure(errorMessage: e.toString()));
    }
  }
}