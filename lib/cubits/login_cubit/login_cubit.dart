import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tawfeer_market/cubits/login_cubit/login_states.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    emit(LoginLoading());

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();
      if (userDoc.exists) {
        String role = userDoc.get('role') ?? 'user';

        emit(LoginSuccess(role: role));
      } else {
        emit(LoginFailure(errorMessage: 'userNotFound'));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(LoginFailure(errorMessage: 'userNotFound'));
      } else if (e.code == 'wrong-password') {
        emit(LoginFailure(errorMessage: 'wrongPassword'));
      } else if (e.code == 'invalid-credential') {
        emit(LoginFailure(errorMessage: 'invalidCredentials'));
      } else {
        emit(LoginFailure(errorMessage: 'loginFailed'));
      }
    } catch (e) {
      emit(LoginFailure(errorMessage: 'loginFailed'));
    }
  }
}
