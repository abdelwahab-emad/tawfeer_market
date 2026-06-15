import 'package:flutter/material.dart';
import 'package:tawfeer_market/pages/add_product_page.dart';
import 'package:tawfeer_market/widgets/add_item.dart';
import 'package:tawfeer_market/widgets/custom_admin_app_bar.dart';
import 'package:tawfeer_market/widgets/admin_products_view.dart';

class AdminProductsPage extends StatelessWidget {
  const AdminProductsPage({super.key});

  static String id = 'products_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: CustomAdminAppBar(
          title: 'Products Managment',
          actionIcon: IconButton(
            icon: const Icon(Icons.filter_list_rounded, color: Colors.black),
            onPressed: () {},
          ),
        ),
      ),
      floatingActionButton: AddItem(onPressed: () {
         Navigator.push(context, MaterialPageRoute(builder: (context) => const AddProductPage()));
      }),

      body: AdminProductsView(),
    );
  }
}
