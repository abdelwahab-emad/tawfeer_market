import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:tawfeer_market/models/product_model.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  StreamSubscription? _cartSubscription;
  double totalCost = 0.0;

  void getCartProducts() {
    emit(CartLoading());
    try {
      String uId = FirebaseAuth.instance.currentUser!.uid;

      _cartSubscription = _firestore
          .collection('users')
          .doc(uId)
          .collection('cart')
          .snapshots()
          .listen(
            (snapshot) async {
              List<ProductModel> cartList = [];

              for (var doc in snapshot.docs) {
                var data = doc.data();

                var productDoc = await _firestore
                    .collection('products')
                    .doc(doc.id)
                    .get();
                int serverStock = 0;
                if (productDoc.exists) {
                  serverStock = (productDoc.data()?['stock'] ?? 0).toInt();
                }

                cartList.add(
                  ProductModel(
                    id: doc.id,
                    name: data['name'] ?? '',
                    imageUrl: data['imageUrl'] ?? '',
                    price: (data['price'] ?? 0).toDouble(),
                    oldPrice: (data['oldPrice'] ?? 0).toDouble(),
                    hasDiscount: data['hasDiscount'] ?? false,
                    type: data['type'] ?? '',
                    categoryId: data['categoryId'] ?? '',
                    stock: serverStock,
                    quantity: data['quantity'] ?? 1,
                  ),
                );
              }

              totalCost = 0.0;
              for (var product in cartList) {
                totalCost += (product.price * (product.quantity ?? 1));
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

  Future<bool> updateQuantity({
    required String productId,
    required int quantity,
  }) async {
    try {
      var productDoc = await _firestore
          .collection('products')
          .doc(productId)
          .get();

      if (productDoc.exists) {
        int serverStock = (productDoc.data()?['stock'] ?? 0).toInt();

        if (quantity > serverStock) {
          return false;
        }
      }

      String uId = FirebaseAuth.instance.currentUser!.uid;
      await _firestore
          .collection('users')
          .doc(uId)
          .collection('cart')
          .doc(productId)
          .update({'quantity': quantity});

      return true;
    } catch (e) {
      print(e.toString());
      return false;
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
        'quantity': product.quantity ?? 1,
      };

      await _firestore
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
      await _firestore
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
      DocumentReference orderRef = _firestore.collection('orders').doc();
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
          'quantity': product.quantity ?? 1,
        };
      }).toList();

      WriteBatch batch = _firestore.batch();

      batch.set(orderRef, {
        'orderId': orderId,
        'userId': uId,
        'items': orderProducts,
        'totalPrice': totalCost,
        'status': 'Pending',
        'orderDate': DateTime.now().toIso8601String(),
      });

      int newAlertsCount = 0;
      for (var product in products) {
        int orderedQty = product.quantity ?? 1;
        var productDoc = await _firestore
            .collection('products')
            .doc(product.id)
            .get();
        if (productDoc.exists) {
          int currentServerStock = (productDoc.data()?['stock'] ?? 0).toInt();
          int finalStock = currentServerStock - orderedQty;
          if (currentServerStock > 5 && finalStock <= 5) {
            newAlertsCount++;
          }
        }
        DocumentReference productRef = _firestore
            .collection('products')
            .doc(product.id);

        batch.update(productRef, {'stock': FieldValue.increment(-orderedQty)});

        DocumentReference cartRef = _firestore
            .collection('users')
            .doc(uId)
            .collection('cart')
            .doc(product.id);

        batch.delete(cartRef);
      }

      if (newAlertsCount > 0) {
        DocumentReference dashboardRef = _firestore
            .collection('analytics')
            .doc('dashboard');
        batch.update(dashboardRef, {
          'stockAlertsCount': FieldValue.increment(newAlertsCount),
        });
      }
      await batch.commit();
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
