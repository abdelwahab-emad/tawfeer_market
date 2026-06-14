import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:tawfeer_market/models/order_model.dart';
import 'package:tawfeer_market/models/product_model.dart';

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
            int pendingCount = 0;
            int deliveredCount = 0;
            int cancelledCount = 0;

            for (var doc in querySnapshot.docs) {
              var data = doc.data();
              var itemsList = data['items'] as List<dynamic>? ?? [];
              
              List<ProductModel> parsedItems = [];
              for (var item in itemsList) {
                var itemMap = Map<String, dynamic>.from(item);
                
                parsedItems.add(
                  ProductModel(
                    id: itemMap['id'] ?? '',
                    name: itemMap['name'] ?? '',
                    imageUrl: itemMap['imageUrl'] ?? '',
                    price: (itemMap['price'] as num? ?? 0).toDouble(),
                    oldPrice: (itemMap['oldPrice'] as num? ?? 0).toDouble(),
                    hasDiscount: itemMap['hasDiscount'] ?? false,
                    type: itemMap['type'] ?? '',
                    categoryId: itemMap['categoryId'] ?? '',
                    stock: itemMap['stock'] ?? 0,
                  ),
                );
              }

              String currentStatus = data['status'] ?? 'Pending';

              if (currentStatus.toLowerCase() == 'pending') {
                pendingCount++;
              } else if (currentStatus.toLowerCase() == 'delivered') {
                deliveredCount++;
              } else if (currentStatus.toLowerCase() == 'cancelled') {
                cancelledCount++;
              }

              orders.add(
                OrderModel(
                  orderId: data['orderId'] ?? doc.id,
                  items: parsedItems,
                  totalPrice: (data['totalPrice'] as num? ?? 0).toDouble(),
                  orderDate: data['orderDate'] != null 
                      ? DateTime.parse(data['orderDate'].toString()) 
                      : DateTime.now(),
                  status: currentStatus,
                ),
              );
            }

            emit(AdminOrdersSuccess(
              orders: orders,
              totalCount: orders.length,
              pendingCount: pendingCount,
              deliveredCount: deliveredCount,
              cancelledCount: cancelledCount,
            ));
          }, onError: (error) {
            emit(AdminOrdersFailure(error.toString()));
          });
    } catch (e) {
      emit(AdminOrdersFailure(e.toString()));
    }
  }

  Future<void> updateOrderStatus({required String orderId, required String newStatus}) async {
    try {
      await _firestore.collection('orders').doc(orderId).update({'status': newStatus});
    } catch (e) {
      emit(AdminOrdersFailure(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _ordersSubscription?.cancel();
    return super.close();
  }
}