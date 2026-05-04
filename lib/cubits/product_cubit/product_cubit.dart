import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:tawfeer_market/models/product_model.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());
  StreamSubscription? _subscription;
  void getProductsByType(String productType) async {
    emit(ProductLoading());
    try {
      var snapshot = await FirebaseFirestore.instance
          .collection('products')
          .where('type', isEqualTo: productType)
          .get();

      List<ProductModel> productsList = snapshot.docs.map((doc) {
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
          stock: data['stock'] ?? 1,
        );
      }).toList();

      emit(ProductSuccess(productsList));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  Future<void> getProductsByCategoryId({required String categoryId}) async {
    emit(ProductLoading());
    try {
      var snapshot = await FirebaseFirestore.instance
          .collection('products')
          .where('categoryId', isEqualTo: categoryId)
          .get();
      List<ProductModel> productsList = snapshot.docs.map((doc) {
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
          stock: data['stock'] ?? 1,
        );
      }).toList();
      emit(ProductSuccess(productsList));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  void getAllProducts() {
    emit(ProductLoading());

    _subscription?.cancel(); 
    _subscription = FirebaseFirestore.instance
        .collection('products')
        .snapshots()
        .listen((snapshot) {
          try {
            List<ProductModel> productsList = snapshot.docs.map((doc) {
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
                stock: data['stock'] ?? 1,
              );
            }).toList();

            emit(ProductSuccess(productsList));
          } catch (e) {
            emit(ProductError(e.toString()));
          }
        });
  }

  Future<void> deleteProduct(String docId) async {
    if (state is ProductSuccess) {
      final currentState = state as ProductSuccess;

      final updatedList = currentState.products
          .where((e) => e.id != docId)
          .toList();

      emit(ProductSuccess(updatedList));

      try {
        await FirebaseFirestore.instance
            .collection('products')
            .doc(docId)
            .delete();
      } catch (e) {
        emit(ProductError(e.toString()));
        getAllProducts();
      }
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
