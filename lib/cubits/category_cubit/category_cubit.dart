import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tawfeer_market/models/category_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryInitial());
  void getCategories() async {
    emit(CategoryLoading());
    try {
      var snapshot = await FirebaseFirestore.instance
          .collection('categories')
          .get();

      List<CategoryModel> categoriesList = snapshot.docs.map((doc) {
        var data = doc.data();
        return CategoryModel(
          id: doc.id,
          name: data['name'] ?? '',
          imageUrl: data['imageUrl'] ?? '',
        );
      }).toList();
      print("done");
      emit(CategorySuccess(categoriesList));
    } catch (e) {
      print('خطا ${e.toString()}');
      emit(CategoryError("There was an error"));
    }
  }
}
