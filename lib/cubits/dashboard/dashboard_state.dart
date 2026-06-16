part of 'dashboard_cubit.dart';

@immutable
sealed class DashboardState {}

final class DashboardInitial extends DashboardState {}

final class DashboardLoading extends DashboardState {}

final class DashboardSuccess extends DashboardState {
  final double totalSales;
  final int ordersCount;
  final int customersCount;
  final int stockAlertsCount;
  final List<int> weeklyOrdersData;
  DashboardSuccess({
    required this.totalSales,
    required this.ordersCount,
    required this.customersCount,
    required this.stockAlertsCount,
    required this.weeklyOrdersData,
  });
}


final class DashboardError extends DashboardState {
  final String errorMessage;

  DashboardError({required this.errorMessage});
}