import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit() : super(DashboardInitial());

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  StreamSubscription? _dashboardSubscription;
  StreamSubscription? _weeklyOrdersSubscription;

  void listenToDashboardData() {
    emit(DashboardLoading());

    _dashboardSubscription = _firestore
        .collection('analytics')
        .doc('dashboard')
        .snapshots()
        .listen(
      (docSnap) {
        if (docSnap.exists) {
          _weeklyOrdersSubscription?.cancel();
          _weeklyOrdersSubscription = _firestore
              .collection('analytics')
              .doc('dashboard')
              .collection('weekly_orders')
              .snapshots()
              .listen((weeklySnap) {
            Map<String, int> daysMap = {
              'Mon': 0,
              'Tue': 0,
              'Wed': 0,
              'Thu': 0,
              'Fri': 0,
              'Sat': 0,
              'Sun': 0,
            };

            for (var doc in weeklySnap.docs) {
              if (daysMap.containsKey(doc.id)) {
                daysMap[doc.id] = (doc.data()['count'] as num).toInt();
              }
            }

            List<int> orderedWeeklyData = [
              daysMap['Mon']!,
              daysMap['Tue']!,
              daysMap['Wed']!,
              daysMap['Thu']!,
              daysMap['Fri']!,
              daysMap['Sat']!,
              daysMap['Sun']!,
            ];

            emit(
              DashboardSuccess(
                totalSales: (docSnap.data()?['totalSales'] as num?)?.toDouble() ?? 0.0,
                ordersCount: docSnap.data()?['ordersCount'] ?? 0,
                customersCount: docSnap.data()?['customersCount'] ?? 0,
                stockAlertsCount: docSnap.data()?['stockAlertsCount'] ?? 0,
                weeklyOrdersData: orderedWeeklyData,
              ),
            );
          });
        } else {
          emit(
            DashboardSuccess(
              totalSales: 0.0,
              ordersCount: 0,
              customersCount: 0,
              stockAlertsCount: 0,
              weeklyOrdersData: [0, 0, 0, 0, 0, 0, 0],
            ),
          );
        }
      },
      onError: (error) {
        emit(DashboardError(errorMessage: error.toString()));
      },
    );
  }

  Future<void> updateWeeklyOrdersChart() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    String currentDay = DateFormat('E').format(DateTime.now());

    await firestore
        .collection('analytics')
        .doc('dashboard')
        .collection('weekly_orders')
        .doc(currentDay)
        .update({'count': FieldValue.increment(1)});
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
    _weeklyOrdersSubscription?.cancel();
    return super.close();
  }
}