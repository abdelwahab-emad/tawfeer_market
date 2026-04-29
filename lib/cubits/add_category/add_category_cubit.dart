import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'add_category_state.dart';

class AddCategoryCubit extends Cubit<AddCategoryState> {
  AddCategoryCubit() : super(AddCategoryInitial());

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  File? selectedImage;

  final cloudinary = CloudinaryPublic('dc7mezh7k', 'upload_test', cache: false);

  Future<void> pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (picked != null) {
      selectedImage = File(picked.path);
      emit(AddCategoryImagePicked(image: selectedImage!));
    }
  }

  Future<void> addCategory({required String name}) async {
    try {
      emit(AddCategoryLoading());

      if (selectedImage == null) {
        emit(AddCategoryFailure(errMessage: "Please select image"));
        return;
      }

      final response = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(selectedImage!.path),
      );

      await _firestore.collection('categories').add({
        'name': name.trim(),
        'imageUrl': response.secureUrl,
        'createdAt': Timestamp.now(),
      });

      selectedImage = null;
      emit(AddCategorySuccess());
    } catch (e) {
      emit(AddCategoryFailure(errMessage: e.toString()));
    }
  }
}
