import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:tawfeer_market/models/product_model.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteInitial());

  StreamSubscription? _favoriteSubscription;

  void getFavoriteProducts() {
    emit(FavoriteLoading());
    try {
      String uId = FirebaseAuth.instance.currentUser!.uid;

      _favoriteSubscription = FirebaseFirestore.instance
          .collection('users')
          .doc(uId)
          .collection('favorites')
          .snapshots()
          .listen(
            (snapshot) {
              List<ProductModel> favoriteList = snapshot.docs.map((doc) {
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
                  quantity: data['quantity'] ?? 1,
                );
              }).toList();

              emit(FavoriteSuccess(products: favoriteList));
            },
            onError: (e) {
              emit(FavoriteFailure(errorMessage: e.toString()));
            },
          );
    } catch (e) {
      emit(FavoriteFailure(errorMessage: e.toString()));
    }
  }

  Future<void> addProductToFavorite({required ProductModel product}) async {

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
          .collection('favorites')
          .doc(product.id)
          .set(productMap);
    } catch (e) {
      print(e.toString());
    }
  }

   Future<void> deleteFromFavorites({required String productId}) async {
    try {
      String uId = FirebaseAuth.instance.currentUser!.uid;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uId)
          .collection('favorites')
          .doc(productId)
          .delete();
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Future<void> close() {
    _favoriteSubscription?.cancel();
    return super.close();
  }
}
