import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  Future<void> getUserData() async {
    emit(UserLoading());
    try {
      String uId = FirebaseAuth.instance.currentUser!.uid;

      var doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(uId)
          .get();

      if (doc.exists) {
        emit(UserSuccess(userData: doc.data()!));
      } else {
        emit(UserFailure(errorMessage: "User data not found in Firestore"));
      }
    } catch (e) {
      emit(UserFailure(errorMessage: "Failed to fetch user data"));
    }
  }

  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    emit(UserLoading());
    try {
      User? user = FirebaseAuth.instance.currentUser;
      String email = user!.email!;

      AuthCredential credential = EmailAuthProvider.credential(
        email: email,
        password: oldPassword,
      );
      await user.reauthenticateWithCredential(credential);
      await user.updatePassword(newPassword);

      await FirebaseFirestore.instance.collection('users').doc(user.uid).update(
        {'password': newPassword},
      );

      emit(UserUpdateSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password' || e.code == 'invalid-credential') {
        emit(UserFailure(errorMessage: "The old password is wrong"));
      } else if (e.code == 'weak-password') {
        emit(UserFailure(errorMessage: "The new password is too weak"));
      } else {
        emit(UserFailure(errorMessage: e.message ?? "An error occurred"));
      }
    } catch (e) {
      emit(UserFailure(errorMessage: e.toString()));
    }
  }

  Future<void> updateUserData({
    required String firstName,
    required String lastName,
  }) async {
    emit(UserLoading());
    try {
      User? user = FirebaseAuth.instance.currentUser;
      String uId = user!.uid;

      await FirebaseFirestore.instance.collection('users').doc(uId).update({
        'firstName': firstName,
        'lastName': lastName,
      });

      await user.updateDisplayName('$firstName $lastName');

      emit(UserUpdateSuccess());
      await user.reload();
    } catch (e) {
      emit(UserFailure(errorMessage: e.toString()));
    }
  }

  Future<void> deleteUserAccount({required String password}) async {
    emit(UserLoading());
    try {
      User? user = FirebaseAuth.instance.currentUser;
      AuthCredential credential = EmailAuthProvider.credential(
        email: user!.email!,
        password: password,
      );

      await user.reauthenticateWithCredential(credential);

      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .delete();

      await user.delete();

      emit(UserDeleteSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        emit(UserFailure(errorMessage: "The old password is wrong"));
      } else {
        emit(UserFailure(errorMessage: e.code));
      }
    } catch (e) {
      emit(UserFailure(errorMessage: e.toString()));
    }
  }
}
