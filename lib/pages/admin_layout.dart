import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tawfeer_market/cubits/admin_nav/admin_nav_cubit.dart';
import 'package:tawfeer_market/widgets/admin_side_bar.dart';
import 'package:tawfeer_market/widgets/admin_main_content.dart';

class AdminMainLayout extends StatelessWidget {
  static const String id = 'admin_main_layout';
  const AdminMainLayout({super.key});

  final List<Widget> _pages = const [
    Center(child: Text('Dashboard', style: TextStyle(fontSize: 30))),
    Center(child: Text('Products', style: TextStyle(fontSize: 30))),
    Center(child: Text('Orders', style: TextStyle(fontSize: 30))),
    Center(child: Text('Users', style: TextStyle(fontSize: 30))),
    Center(child: Text('Categories', style: TextStyle(fontSize: 30))),
    Center(child: Text('Settings', style: TextStyle(fontSize: 30))),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AdminNavCubit(),
      child: BlocBuilder<AdminNavCubit, AdminNavState>(
        builder: (context, state) {
          var cubit = context.read<AdminNavCubit>();

          return Scaffold(
            backgroundColor: const Color(0xFFF8F9FA),
            body: Stack(
              children: [
                AdminMainContent(
                  title: 'ADMIN DASHBOARD',
                  isCollapsed: cubit.isCollapsed,
                  child: _pages[cubit.currentIndex],
                ),

                AdminSidebar(
                  isCollapsed: cubit.isCollapsed,
                  currentIndex: cubit.currentIndex,
                  onToggle: () => cubit.toggleMenu(),
                  onPageChanged: (index) => cubit.changePage(index),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}