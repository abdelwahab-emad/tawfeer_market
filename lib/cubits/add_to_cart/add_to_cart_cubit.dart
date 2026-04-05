import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:tawfeer_market/models/product_model.dart';

part 'add_to_cart_state.dart';

class AddToCartCubit extends Cubit<AddToCartState> {
  AddToCartCubit() : super(AddToCartInitial());

  Future<void> addProductToCart({required ProductModel product}) async{
     emit(AddToCartLoading());

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
      };
      await FirebaseFirestore.instance
      .collection('users')
      .doc(uId)
      .collection('cart')
      .doc(product.id)
      .set(productMap);
    
      emit(AddToCartSuccess());
     } catch (e) {
      emit(AddToCartFailure(errorMessage: e.toString()));
     }
  }
}
