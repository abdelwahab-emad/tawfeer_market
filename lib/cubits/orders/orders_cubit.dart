import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tawfeer_market/models/order_model.dart';
import 'package:tawfeer_market/models/product_model.dart';
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
              status: data['status'] ?? 'pending',
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

  void fetchOrderDetails(String orderId) async {
    emit(OrdersLoading());
    try {
      var doc = await FirebaseFirestore.instance.collection('orders').doc(orderId).get();
      if (doc.exists) {
        var data = doc.data()!;
        List<ProductModel> productItems = (data['items'] as List).map((item) {
          return ProductModel(
            id: item['id'],
            name: item['name'],
            imageUrl: item['imageUrl'],
            price: (item['price'] as num).toDouble(),
            oldPrice: (item['oldPrice'] as num).toDouble(),
            hasDiscount: item['hasDiscount'],
            type: item['type'],
            categoryId: item['categoryId'],
            quantity: item['quantity'],
          );
        }).toList();

        emit(OrderDetailsSuccess(
          order: OrderModel(
            orderId: data['orderId'],
            items: productItems,
            totalPrice: (data['totalPrice'] as num).toDouble(),
            orderDate: DateTime.parse(data['orderDate']),
            status: data['status'] ?? 'pending',
          ),
        ));
      }
    } catch (e) {
      emit(OrdersFailure(errorMessage: e.toString()));
    }
  }
}