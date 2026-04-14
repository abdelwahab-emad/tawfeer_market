import 'package:flutter/material.dart';
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
            onTap: () {}
          ),
          HubCard(
            title: 'Products',
            icon: Icons.shopping_bag_outlined,
            color: Colors.blue,
            onTap: () {},
          ),
          HubCard(
            title: 'Orders',
            icon: Icons.assignment_outlined,
            color: Colors.green,
            onTap: () {},
          ),
          HubCard(
            title: 'Users',
            icon: Icons.people_outline,
            color: Colors.purple,
            onTap: () {},
          ),
          HubCard(
            title: 'Categories',
            icon: Icons.category_outlined,
            color: Colors.teal,
            onTap: () {},
          ),
          HubCard(
            title: 'Settings',
            icon: Icons.settings_outlined,
            color: Colors.grey,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}