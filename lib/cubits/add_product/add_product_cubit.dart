import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'add_product_state.dart';

class AddProductCubit extends Cubit<AddProductState> {
  AddProductCubit() : super(AddProductInitial());

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  File? selectedImage;

  final cloudinary = CloudinaryPublic('dc7mezh7k', 'upload_test', cache: false);

  Future<void> pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (picked != null) {
      selectedImage = File(picked.path);
      emit(AddProductImagePicked(image: selectedImage!));
    }
  }

  void addProduct({
    required String name,
    required String categoryId,
    required double price,
    required double discount,
    required int initialStock,
    required String type,
  }) async {
    try {
      emit(AddProductLoading());

      if (selectedImage == null) {
        emit(AddProductFailure(errMessage: 'Please select image'));
        return;
      }

      final response = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(selectedImage!.path),
      );

      
      double finalPrice = double.parse(price.toStringAsFixed(2));
      double oldPrice = 0.0;
      bool hasDiscount = false;

      if (discount > 0.0) {
        double calculatedPrice = price - (price * (discount / 100));
        finalPrice = double.parse(calculatedPrice.toStringAsFixed(2));
        oldPrice = double.parse(price.toStringAsFixed(2));
        hasDiscount = true;
      }

      await _firestore.collection('products').add({
        'name': name.trim(),
        'imageUrl': response.secureUrl,
        'categoryId': categoryId,
        'price': finalPrice,
        'oldPrice': oldPrice,
        'hasDiscount': hasDiscount,
        'stock': initialStock,
        'type': type,
        'createdAt': Timestamp.now(),
      });

      emit(AddProductSuccess());
    } catch (e) {
      emit(AddProductFailure(errMessage: e.toString()));
    }
  }

  Future<void> updateProduct({
    required String name,
    required String categoryId,
    required double price,
    required double discount,
    required int initialStock,
    required String docId,
    required String url,
    required String type,
  }) async {
    try {
      emit(UpdateProductLoading());
      String imageUrl = url;
      if (selectedImage != null) {
        final response = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(selectedImage!.path),
        );
        imageUrl = response.secureUrl;
      }

      double finalPrice = double.parse(price.toStringAsFixed(2));
      double oldPrice = 0.0;
      bool hasDiscount = false;

      if (discount > 0.0) {
        double calculatedPrice = price - (price * (discount / 100));
        finalPrice = double.parse(calculatedPrice.toStringAsFixed(2));
        oldPrice = double.parse(price.toStringAsFixed(2));
        hasDiscount = true;
      }

      await _firestore.collection('products').doc(docId).update({
        'name': name.trim(),
        'imageUrl': imageUrl,
        'categoryId': categoryId,
        'price': finalPrice,
        'oldPrice': oldPrice,
        'hasDiscount': hasDiscount,
        'stock': initialStock,
        'type': type,
      });

      emit(UpdateProductSuccess());
    } catch (e) {
      emit(AddProductFailure(errMessage: e.toString()));
    }
  }

  void clearImage() {
    selectedImage = null;
    emit(AddProductInitial());
  }
}
