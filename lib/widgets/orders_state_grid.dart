import 'package:flutter/material.dart';
import 'package:tawfeer_market/widgets/orders_state_card.dart';

class OrdersStateGrid extends StatelessWidget {
  const OrdersStateGrid({
    super.key,
    required this.total,
    required this.pending,
    required this.delivered,
    required this.cancelled,
  });
  final int total;
  final int pending;
  final int delivered;
  final int cancelled;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: OrdersStateCard(
                title: 'Total Orders',
                value: total.toString(),
                percentage: '↑ 8.2%',
              ),
            ),
            SizedBox(width: 15),
            Expanded(
              child: OrdersStateCard(
                title: 'Pending',
                value: pending.toString(),
                percentage: '↑ 2.4%',
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            Expanded(
              child: OrdersStateCard(
                title: 'Delivered',
                value: delivered.toString(),
                percentage: '↑ 5.1%',
              ),
            ),
            SizedBox(width: 15),
            Expanded(
              child: OrdersStateCard(
                title: 'Cancelled',
                value: cancelled.toString(),
                percentage: '↓ 2.4%',
              ),
            ),
          ],
        ),
      ],
    );
  }
}
