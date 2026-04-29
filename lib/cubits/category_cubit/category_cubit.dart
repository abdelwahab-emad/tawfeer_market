import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tawfeer_market/models/category_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryInitial());

  StreamSubscription? _subscription;

  void getCategories() {
    emit(CategoryLoading());

    _subscription = FirebaseFirestore.instance
        .collection('categories')
        .snapshots()
        .listen(
      (snapshot) {
        final categoriesList = snapshot.docs.map((doc) {
          final data = doc.data();

          return CategoryModel(
            id: doc.id,
            name: data['name'] ?? '',
            imageUrl: data['imageUrl'] ?? '',
          );
        }).toList();

        emit(CategorySuccess(categoriesList));
      },
      onError: (e) {
        emit(CategoryError(e.toString()));
      },
    );
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}