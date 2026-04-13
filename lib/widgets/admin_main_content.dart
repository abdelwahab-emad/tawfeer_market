import 'package:flutter/material.dart';
import 'package:tawfeer_market/widgets/admin_header.dart';

class AdminMainContent extends StatelessWidget {
  final String title;
  final bool isCollapsed;
  final Widget child;

  const AdminMainContent({
    super.key,
    required this.title,
    required this.isCollapsed,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AdminHeader(title: title),
        Expanded(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.only(left: isCollapsed ? 90 : 0),
            child: child,
          ),
        ),
      ],
    );
  }
}

