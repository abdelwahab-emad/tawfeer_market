import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:tawfeer_market/models/order_model.dart';
import 'package:tawfeer_market/models/product_model.dart';

part 'order_details_state.dart';

class OrderDetailsCubit extends Cubit<OrderDetailsState> {
  OrderDetailsCubit() : super(OrderDetailsInitial());

  Future<void> fetchOrderDetails(String orderId) async {
    emit(OrderDetailsLoading());

    try {
      final doc = await FirebaseFirestore.instance
          .collection('orders')
          .doc(orderId)
          .get();

      if (!doc.exists) {
        emit(
          OrderDetailsFailure(
            errorMessage: 'Order not found',
          ),
        );
        return;
      }

      final data = doc.data()!;

      final List<ProductModel> productItems =
          (data['items'] as List).map((item) {
        return ProductModel(
          id: item['id'],
          name: item['name'],
          imageUrl: item['imageUrl'],
          price: (item['price'] as num).toDouble(),
          oldPrice: (item['oldPrice'] as num).toDouble(),
          hasDiscount: item['hasDiscount'],
          type: item['type'],
          categoryId: item['categoryId'],
          stock: item['quantity'],
        );
      }).toList();

      emit(
        OrderDetailsSuccess(
          order: OrderModel(
            orderId: data['orderId'],
            items: productItems,
            totalPrice: (data['totalPrice'] as num).toDouble(),
            orderDate: DateTime.parse(data['orderDate']),
            status: data['status'] ?? 'Pending',
          ),
        ),
      );
    } catch (e) {
      emit(
        OrderDetailsFailure(
          errorMessage: e.toString(),
        ),
      );
    }
  }
}