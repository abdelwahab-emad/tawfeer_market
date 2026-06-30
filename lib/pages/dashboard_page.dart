import 'package:flutter/material.dart';
import 'package:tawfeer_market/widgets/custom_admin_app_bar.dart';
import 'package:tawfeer_market/widgets/dashboardView.dart';

class DashboardPage extends StatelessWidget {
  static const String id = 'dashboard_page';
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: CustomAdminAppBar(
          title: 'DASHBOARD',
          // actionIcon: IconButton(
          //   onPressed: () {},
          //   // icon: const Icon(
          //   //   Icons.settings_outlined,
          //   //   color: Colors.grey,
          //   //   size: 22,
          //   // ),
          // ),
        ),
      ),
      body: DashboardView(),
    );
  }
}
