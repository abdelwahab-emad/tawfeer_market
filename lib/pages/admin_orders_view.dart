import 'package:flutter/material.dart';
import 'package:tawfeer_market/widgets/orders_state_grid.dart';

class AdminOrdersView extends StatelessWidget {
  const AdminOrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          OrdersStateGrid(),
        ],
      ),
    );
  }
}