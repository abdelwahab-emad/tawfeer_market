import 'package:flutter/material.dart';
import 'package:tawfeer_market/widgets/add_item.dart';
import 'package:tawfeer_market/widgets/custom_admin_app_bar.dart';
import 'package:tawfeer_market/widgets/manage_categories_view.dart';

class ManageCategoriesPage extends StatelessWidget {
  const ManageCategoriesPage({super.key});
  static String id = 'Manage_Cagtegories_page';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: CustomAdminAppBar(
          title: 'Categories Managment',
          actionIcon: IconButton(
            icon: const Icon(Icons.filter_list_rounded, color: Colors.black),
            onPressed: () {},
          ),
        ),
      ),
      floatingActionButton: AddItem(onPressed: () {}),
      body: ManageCategoriesView(),
    );
  }
}
