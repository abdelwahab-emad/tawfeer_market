import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tawfeer_market/cubits/register_cubit/register_states.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  Future<void> registerUser({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    emit(RegisterLoading());

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
            'firstName': firstName,
            'lastName': lastName,
            'password': password,
            'email': email,
            'uId': userCredential.user!.uid,
            'createdAt': DateTime.now().toIso8601String(),
            'role': 'user',
          });
      await userCredential.user!.updateDisplayName('${firstName} ${lastName}');

      emit(RegisterSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(RegisterFailure(errorMessage: 'weakPassword'));
      } else if (e.code == 'email-already-in-use') {
        emit(RegisterFailure(errorMessage: 'emailAlreadyInUse'));
      } else if (e.code == 'invalid-email') {
        emit(RegisterFailure(errorMessage: 'invalidEmail'));
      } else {
        emit(RegisterFailure(errorMessage: 'registerFailed'));
      }
    } catch (e) {
      emit(RegisterFailure(errorMessage: 'registerFailed'));
    }
  }
}
