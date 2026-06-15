import 'package:flutter/material.dart';
import 'package:tawfeer_market/widgets/dashboard_view.dart';
import 'package:tawfeer_market/widgets/sales_analystics_chart.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          DashboardStatesGrid(),
          SizedBox(height: 30),
          SalesAnalyticsChart(),
        //  SizedBox(height: 30),
        //  RecentOrdersList(),
        ],
      ),
    );
  }
}
