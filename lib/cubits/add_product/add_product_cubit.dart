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

      await _firestore.collection('products').add({
        'name': name.trim(),
        'imageUrl': response.secureUrl,
        'categoryId': categoryId,
        'price': discount > 0.0 ? discount : price,
        'oldPrice': discount > 0.0 ? price : 0.0,
        'hasDiscount': discount > 0.0 ? true : false,
        'stock': initialStock,
        'createdAt': Timestamp.now(),
      });

      emit(AddProductSuccess());
    } catch (e) {
      emit(AddProductFailure(errMessage: e.toString()));
    }
  }

  void clearImage() {
    selectedImage = null;
    emit(AddProductInitial());
  }
}
