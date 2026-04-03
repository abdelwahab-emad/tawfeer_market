import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:tawfeer_market/models/product_model.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());

  void getProducts(String productType) async {
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
        );
      }).toList();

      emit(ProductSuccess(productsList));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }
}
