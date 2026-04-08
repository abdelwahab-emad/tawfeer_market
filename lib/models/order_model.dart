import 'package:tawfeer_market/models/product_model.dart';

class OrderModel {
  final String orderId;
  final List<ProductModel> items;
  final double totalPrice;
  final DateTime orderDate;
  final String status;

  OrderModel({
    required this.orderId,
    required this.items,
    required this.totalPrice,
    required this.orderDate,
    required this.status,
  });
}
