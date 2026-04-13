import 'package:flutter/material.dart';
import 'package:tawfeer_market/constants.dart';
import 'admin_side_menu_item.dart'; 

class AdminSidebar extends StatelessWidget {
  final bool isCollapsed;
  final int currentIndex;
  final VoidCallback onToggle;
  final Function(int) onPageChanged;

  const AdminSidebar({
    super.key,
    required this.isCollapsed,
    required this.currentIndex,
    required this.onToggle,
    required this.onPageChanged,
  });
  
  double getSidebarWidth(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    if(isCollapsed) {
      return screenWidth * 0.17;
    } else {
      return screenWidth * 0.54;
    }
  }
  @override
  Widget build(BuildContext context) {

    
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: getSidebarWidth(context),
      height: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xFFF8F9FA),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            offset: Offset(2, 0),
          )
        ],
      ),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Align(
            alignment: isCollapsed ? Alignment.center : Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: IconButton(
                icon: Icon(isCollapsed ? Icons.menu : Icons.menu_open),
                onPressed: onToggle,
                color: const Color(kprimarycolor),
              ),
            ),
          ),
          const SizedBox(height: 10),
          CircleAvatar(
            backgroundColor: const Color(kprimarycolor),
            radius: isCollapsed ? 20 : 25,
            child: const Text(
              'ε',
              style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 40),
          
          AdminSideMenuItem(
            index: 0,
            currentIndex: currentIndex,
            isCollapsed: isCollapsed,
            icon: Icons.grid_view_rounded,
            label: 'DASHBOARD',
            onTap: onPageChanged,
          ),
          AdminSideMenuItem(
            index: 1,
            currentIndex: currentIndex,
            isCollapsed: isCollapsed,
            icon: Icons.shopping_bag_outlined,
            label: 'PRODUCTS',
            onTap: onPageChanged,
          ),
          AdminSideMenuItem(
            index: 2,
            currentIndex: currentIndex,
            isCollapsed: isCollapsed,
            icon: Icons.assignment_outlined,
            label: 'ORDERS',
            onTap: onPageChanged,
          ),
          AdminSideMenuItem(
            index: 3,
            currentIndex: currentIndex,
            isCollapsed: isCollapsed,
            icon: Icons.people_outline,
            label: 'USERS',
            onTap: onPageChanged,
          ),
          AdminSideMenuItem(
            index: 4,
            currentIndex: currentIndex,
            isCollapsed: isCollapsed,
            icon: Icons.category_outlined,
            label: 'CATEGORIES',
            onTap: onPageChanged,
          ),
          AdminSideMenuItem(
            index: 5,
            currentIndex: currentIndex,
            isCollapsed: isCollapsed,
            icon: Icons.settings_outlined,
            label: 'SETTINGS',
            onTap: onPageChanged,
          ),
        ],
      ),
    );
  }
}