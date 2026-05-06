import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:tawfeer_market/models/user_model.dart';

part 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  UsersCubit() : super(UserInitial());
  StreamSubscription? subscription;
  List<UserModel> usersList = [];
  Future<void> getUsers() async {
    emit(UserLoading());

    subscription = FirebaseFirestore.instance
        .collection('users')
        .snapshots()
        .listen(
          (snapshot) {
            usersList = snapshot.docs.map((doc) {
              final data = doc.data();

              return UserModel(
                uId: data['uId'] ?? '',
                firstName: data['firstName'] ?? '',
                lastName: data['lastName'] ?? '',
                email: data['email'] ?? '',
                password: data['password'] ?? '',
                role: data['role'] ?? '',
                status: data['status'] ?? '',
                createdAt: DateTime.parse(
                  data['createdAt'] ?? DateTime.now().toIso8601String(),
                ),
                image: data['image'],
              );
            }).toList();
            emit(UserSuccess(usersList));
          },
          onError: (e) {
            emit(UserError(e.toString()));
          },
        );
  }

  @override
  Future<void> close() {
    subscription?.cancel();
    return super.close();
  }
}
