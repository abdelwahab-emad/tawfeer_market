import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tawfeer_market/models/category_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryInitial());

  StreamSubscription? _subscription;
  List<CategoryModel> categories = [];
  void getCategories() {
    emit(CategoryLoading());

    _subscription = FirebaseFirestore.instance
        .collection('categories')
        .snapshots()
        .listen(
          (snapshot) {
            categories = snapshot.docs.map((doc) {
              final data = doc.data();

              return CategoryModel(
                id: doc.id,
                name: data['name'] ?? '',
                imageUrl: data['imageUrl'] ?? '',
              );
            }).toList();

            emit(CategorySuccess(categories));
          },
          onError: (e) {
            emit(CategoryError(e.toString()));
          },
        );
  }

  Future<void> deleteCategory(String docId) async {
    if (state is CategorySuccess) {
      final currentState = state as CategorySuccess;

      final updatedList = currentState.categoriesList
          .where((e) => e.id != docId)
          .toList();

      emit(CategorySuccess(updatedList));

      try {
        await FirebaseFirestore.instance
            .collection('categories')
            .doc(docId)
            .delete();
      } catch (e) {
        emit(CategoryError(e.toString()));
        getCategories();
      }
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
