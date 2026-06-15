import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit() : super(DashboardInitial());

 final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  StreamSubscription? _dashboardSubscription;

  void listenToDashboardData() {
    emit(DashboardLoading());

    _dashboardSubscription?.cancel();

    _dashboardSubscription = _firestore
        .collection('analytics')
        .doc('dashboard')
        .snapshots()
        .listen(
      (docSnap) {
        if (docSnap.exists) {
          final data = docSnap.data() as Map<String, dynamic>?;

          emit(DashboardSuccess(
            totalSales: (data?['totalSales'] ?? 0).toDouble(),
            ordersCount: data?['ordersCount'] ?? 0,
            customersCount: data?['customersCount'] ?? 0,
            stockAlertsCount: data?['stockAlertsCount'] ?? 0,
          ));
        } else {
          emit(DashboardSuccess(
            totalSales: 0.0,
            ordersCount: 0,
            customersCount: 1,
            stockAlertsCount: 0,
          ));
        }
      },
      onError: (error) {
        emit(DashboardError(error.toString()));
      },
    );
  }
  
  Future<void> incrementCustomersCount() async {
    try {
      await _firestore.collection('analytics').doc('dashboard').update({
        'customersCount': FieldValue.increment(1),
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> incrementOrdersCount() async {
    try {
      await _firestore.collection('analytics').doc('dashboard').update({
        'ordersCount': FieldValue.increment(1),
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> incrementTotalSales({required double orderPrice}) async {
    try {
      await _firestore.collection('analytics').doc('dashboard').update({
        'totalSales': FieldValue.increment(orderPrice),
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> updateStockAlertsCount({required int value}) async {
    try {
      await _firestore.collection('analytics').doc('dashboard').update({
        'stockAlertsCount': FieldValue.increment(value),
      });
    } catch (e) {
      print(e.toString());
    }
  }
  @override
  Future<void> close() {
    _dashboardSubscription?.cancel();
    return super.close();
  }
}