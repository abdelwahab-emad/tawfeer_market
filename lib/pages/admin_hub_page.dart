import 'package:flutter/material.dart';
import 'package:tawfeer_market/widgets/admin_hub_view.dart';
import 'package:tawfeer_market/widgets/admin_app_bar.dart';

class AdminHubPage extends StatelessWidget {
  const AdminHubPage({super.key});

  static final id = 'Admin_hub_page';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AdminAppBar(),
      body: const AdminHubView(),
    );
  }
}
