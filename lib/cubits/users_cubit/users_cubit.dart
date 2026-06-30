import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:tawfeer_market/cubits/dashboard/dashboard_cubit.dart';
import 'package:tawfeer_market/models/user_model.dart';

part 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  UsersCubit({required this.dashboardCubit}) : super(UserInitial());
  StreamSubscription? subscription;
    final DashboardCubit dashboardCubit;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<UserModel> usersList = [];


  Future<void> getUsers() async {
    emit(UserLoading());

    subscription = _firestore
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

  Future<void> deleteUser(String userId) async {
    try {
      emit(UserLoading());
      final orderSnapshot = await _firestore
          .collection('orders')
          .where('userId', isEqualTo: userId)
          .get();

      WriteBatch batch = _firestore.batch();
      int deliveredOrders = 0;
      double deliverdSales = 0;
      for (final doc in orderSnapshot.docs) {
        final data = doc.data();
        if (data['status'] == 'Delivered') {
          deliveredOrders++;
          deliverdSales += (data['totalPrice'] as num).toDouble();
        }
        batch.delete(doc.reference);
      }

      final userDoc = await _firestore.collection('users').doc(userId).get();

      if (userDoc.exists) {
        batch.delete(userDoc.reference);
      } else {
        final query = await _firestore
            .collection('users')
            .where('uId', isEqualTo: userId)
            .limit(1)
            .get();

        if (query.docs.isNotEmpty) {
          batch.delete(query.docs.first.reference);
        }
      }
      await batch.commit();
      await dashboardCubit.updateCustomersCount(value: -1);
      if (deliveredOrders > 0) {
        await dashboardCubit.updateOrdersCount(value: -deliveredOrders);
        await dashboardCubit.updateTotalSales(value: -deliverdSales);
      } 

    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    subscription?.cancel();
    return super.close();
  }
}
