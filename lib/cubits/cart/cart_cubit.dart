import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:tawfeer_market/models/product_model.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  StreamSubscription? _cartSubscription;
  double totalCost = 0.0;

  void getCartProducts() {
    emit(CartLoading());
    try {
      String uId = FirebaseAuth.instance.currentUser!.uid;

      _cartSubscription = FirebaseFirestore.instance
          .collection('users')
          .doc(uId)
          .collection('cart')
          .snapshots()
          .listen(
        (snapshot) {
          List<ProductModel> cartList = snapshot.docs.map((doc) {
            var data = doc.data();
            return ProductModel(
              id: doc.id,
              name: data['name'] ?? '',
              imageUrl: data['imageUrl'] ?? '',
              price: (data['price'] ?? 0).toDouble(),
              oldPrice: (data['oldPrice'] ?? 0).toDouble(),
              hasDiscount: data['hasDiscount'] ?? false,
              type: data['type'] ?? '',
              categoryId: data['categoryId'] ?? '',
              stock: data['quantity'] ?? 1,
            );
          }).toList();

          totalCost = 0.0;
          for (var product in cartList) {
            totalCost += (product.price * product.stock);
          }
          emit(CartSuccess(products: cartList));
        },
        onError: (e) {
          emit(CartFailure(errorMessage: e.toString()));
        },
      );
    } catch (e) {
      emit(CartFailure(errorMessage: e.toString()));
    }
  }

  Future<void> updateQuantity({
    required String productId,
    required int quantity,
  }) async {
    try {
      String uId = FirebaseAuth.instance.currentUser!.uid;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uId)
          .collection('cart')
          .doc(productId)
          .update({'quantity': quantity});
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> addProductToCart({required ProductModel product}) async {
    try {
      String uId = FirebaseAuth.instance.currentUser!.uid;

      Map<String, dynamic> productMap = {
        'id': product.id,
        'name': product.name,
        'imageUrl': product.imageUrl,
        'price': product.price,
        'oldPrice': product.oldPrice,
        'hasDiscount': product.hasDiscount,
        'type': product.type,
        'categoryId': product.categoryId,
        'quantity': 1,
      };
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uId)
          .collection('cart')
          .doc(product.id)
          .set(productMap);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> deleteFromCart({required String productId}) async {
    try {
      String uId = FirebaseAuth.instance.currentUser!.uid;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uId)
          .collection('cart')
          .doc(productId)
          .delete();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> confirmOrder({required List<ProductModel> products}) async {
    try {
      String uId = FirebaseAuth.instance.currentUser!.uid;
      DocumentReference orderRef = FirebaseFirestore.instance.collection('orders').doc();
      String orderId = orderRef.id;

      List<Map<String, dynamic>> orderProducts = products.map((product) {
        return {
          'id': product.id,
          'name': product.name,
          'imageUrl': product.imageUrl,
          'price': product.price,
          'oldPrice': product.oldPrice,
          'hasDiscount': product.hasDiscount,
          'type': product.type,
          'categoryId': product.categoryId,
          'quantity': product.stock,
        };
      }).toList();

      await orderRef.set({
        'orderId': orderId,
        'userId': uId,
        'items': orderProducts,
        'totalPrice': totalCost,
        'status': 'Pending',
        'orderDate': DateTime.now().toIso8601String(),
      });

      await Future.wait(products.map((product) => deleteFromCart(productId: product.id)));
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Future<void> close() {
    _cartSubscription?.cancel();
    return super.close();
  }
}