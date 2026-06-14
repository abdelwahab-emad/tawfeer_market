import 'package:flutter/material.dart';
import 'package:tawfeer_market/widgets/orders_state_card.dart';

class OrdersStateGrid extends StatelessWidget {
  const OrdersStateGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            Expanded(
              child: OrdersStateCard(
                title: 'Total Orders',
                value: '1,450',
                percentage: '↑ 8.2%',
              ),
            ),
            SizedBox(width: 15),
            Expanded(
              child: OrdersStateCard(
                title: 'Pending',
                value: '38',
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
                value: '1,380',
                percentage: '↑ 5.1%',
              ),
            ),
            SizedBox(width: 15),
            Expanded(
              child: OrdersStateCard(
                title: 'Cancelled',
                value: '32',
                percentage: '↓ 2.4%',
              ),
            ),
          ],
        ),
      ],
    );
  }
}