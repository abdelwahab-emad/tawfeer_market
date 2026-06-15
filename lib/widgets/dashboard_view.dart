import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tawfeer_market/constants.dart';
import 'package:tawfeer_market/cubits/dashboard/dashboard_cubit.dart';
import 'package:tawfeer_market/widgets/state_card.dart';

class DashboardStatesGrid extends StatelessWidget {
  const DashboardStatesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: (context, state) {
        if (state is DashboardLoading) {
          return const Center(
            child: CircularProgressIndicator(color: Color(kprimarycolor)),
          );
        } else if (state is DashboardError) {
          return Center(
            child: Text(
              state.errorMessage,
              style: const TextStyle(color: Colors.red, fontSize: 14),
            ),
          );
        } else if (state is DashboardSuccess) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Sales Overview",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D3436),
                ),
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: StateCard(
                      title: 'Total Sales',
                      value: '${state.totalSales} EGP',
                      percentage: '↑ 12.5%',
                      icon: Icons.account_balance_wallet_outlined,
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: StateCard(
                      title: 'Orders',
                      value: state.ordersCount.toString(),
                      percentage: '↑ 8.2%',
                      icon: Icons.shopping_cart_outlined,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children:  [
                  Expanded(
                    child: StateCard(
                      title: 'Customers',
                      value: state.customersCount.toString(),
                      percentage: '↑ 5.1%',
                      icon: Icons.people_outline,
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: StateCard(
                      title: 'Stock Alerts',
                      value: state.stockAlertsCount.toString(),
                      percentage: '↓ 2.4%',
                      icon: Icons.warning_amber_rounded,
                    ),
                  ),
                ],
              ),
            ],
          );
        }
        return const SizedBox();
      },
    );
  }
}
