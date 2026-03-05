import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tawfeer_market/cubits/register_cubit/register_states.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  Future<void> registerUser({required String email, required String password,}) async {
    emit(RegisterLoading());

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ); 

      emit(RegisterSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(
          RegisterFailure(errorMessage: 'The password provided is too weak'),
        );
      } else if (e.code == 'email-already-in-use') {
        emit(
          RegisterFailure(
            errorMessage: 'This account is already registerd',
          ),
        );
      } else if (e.code == 'invalid-email') {
        emit(
          RegisterFailure(
            errorMessage: 'The email address is badly formatted',
          ),
        );
      } else {
        emit(
          RegisterFailure(
            errorMessage: e.message ?? 'Registration failed, please try again',
          ),
        );
      }
    } catch (e) {
      emit(
        RegisterFailure(
          errorMessage: 'An unexpected error occurred. Please try again later',
        ),
      );
    }
  }
}