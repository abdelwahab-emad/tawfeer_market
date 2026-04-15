import 'package:flutter/material.dart';
import 'package:tawfeer_market/widgets/sales_analystics_chart_view.dart';

class SalesAnalyticsChart extends StatelessWidget {
  const SalesAnalyticsChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Orders Analytics",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2D3436),
          ),
        ),
        Text(
          "Weekly order volume overview",
          style: TextStyle(fontSize: 13, color: Colors.grey),
        ),
        const SizedBox(height: 15),
        const SalesAnalysticsChartView(),
      ],
    );
  }
}

