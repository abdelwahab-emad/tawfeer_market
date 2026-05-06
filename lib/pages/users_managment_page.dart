import 'package:flutter/material.dart';
import 'package:tawfeer_market/widgets/custom_admin_app_bar.dart';
import 'package:tawfeer_market/widgets/users_managment_view.dart';

class UsersManagmentPage extends StatelessWidget {
  const UsersManagmentPage({super.key});

  static String id = 'users_managment_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: CustomAdminAppBar(
          title: 'Users Management',
          actionIcon: IconButton(
            icon: const Icon(Icons.filter_list_rounded, color: Colors.black),
            onPressed: () {},
          ),
        ),
      ),
      body: UsersManagmentView(),
    );
  }
}
