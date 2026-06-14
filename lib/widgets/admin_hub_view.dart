import 'package:flutter/material.dart';
import 'package:tawfeer_market/pages/admin_orders_page.dart';
import 'package:tawfeer_market/pages/admin_settings_page.dart';
import 'package:tawfeer_market/pages/dashboard_page.dart';
import 'package:tawfeer_market/pages/manage_categories_page.dart';
import 'package:tawfeer_market/pages/products_page.dart';
import 'package:tawfeer_market/pages/users_managment_page.dart';
import 'package:tawfeer_market/widgets/hub_card.dart';

class AdminHubView extends StatelessWidget {
  const AdminHubView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        children: [
          HubCard(
            title: 'Dashboard',
            icon: Icons.grid_view_rounded,
            color: Colors.orange,
            onTap: () {
              Navigator.pushNamed(context, DashboardPage.id);
            },
          ),
          HubCard(
            title: 'Products',
            icon: Icons.shopping_bag_outlined,
            color: Colors.blue,
            onTap: () {
              Navigator.pushNamed(context, ProductsPage.id);
            },
          ),
          HubCard(
            title: 'Orders',
            icon: Icons.assignment_outlined,
            color: Colors.green,
            onTap: () {
              Navigator.pushNamed(context, AdminOrdersPage.id);
            },
          ),
          HubCard(
            title: 'Users',
            icon: Icons.people_outline,
            color: Colors.purple,
            onTap: () {
              Navigator.pushNamed(context, UsersManagmentPage.id);
            },
          ),
          HubCard(
            title: 'Categories',
            icon: Icons.category_outlined,
            color: Colors.teal,
            onTap: () {
              Navigator.pushNamed(context, ManageCategoriesPage.id);
            },
          ),
          HubCard(
            title: 'Settings',
            icon: Icons.settings_outlined,
            color: Colors.grey,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AdminSettingsPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
