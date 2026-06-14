import 'package:flutter/material.dart';
import 'package:tawfeer_market/pages/admin_orders_view.dart';
import 'package:tawfeer_market/widgets/custom_admin_app_bar.dart';

class AdminOrdersPage extends StatelessWidget {
  const AdminOrdersPage({super.key});

  static String id = 'admin_orders_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: CustomAdminAppBar(
          title: 'Orders Managment',
          actionIcon: IconButton(
            icon: const Icon(Icons.filter_list_rounded, color: Colors.black),
            onPressed: () {},
          ),
        ),
      ),
      body : AdminOrdersView(),
    );
  }
}
