import 'package:flutter/material.dart';
import 'package:tawfeer_market/widgets/state_card.dart';

class DashboardStatsGrid extends StatelessWidget {
  const DashboardStatsGrid({super.key});

  @override
  Widget build(BuildContext context) {
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
          children: const [
            Expanded(
              child: StateCard(
                title: 'Total Sales',
                value: '125,750 EGP',
                percentage: '↑ 12.5%',
                icon: Icons.account_balance_wallet_outlined,
              ),
            ),
            SizedBox(width: 15),
            Expanded(
              child: StateCard(
                title: 'Orders',
                value: '1,450',
                percentage: '↑ 8.2%',
                icon: Icons.shopping_cart_outlined,
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        Row(
          children: const [
            Expanded(
              child: StateCard(
                title: 'Customers',
                value: '120',
                percentage: '↑ 5.1%',
                icon: Icons.people_outline,
              ),
            ),
            SizedBox(width: 15),
            Expanded(
              child: StateCard(
                title: 'Stock Alerts',
                value: '15',
                percentage: '↓ 2.4%',
                icon: Icons.warning_amber_rounded,
              ),
            ),
          ],
        ),
      ],
    );
  }
}