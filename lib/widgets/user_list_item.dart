import 'package:flutter/material.dart';
import 'package:tawfeer_market/constants.dart';

class UserListItem extends StatelessWidget {
  const UserListItem({
    super.key,
    required this.name,
    required this.email,
    required this.createdAt,
    required this.status,
  });

  final String name;
  final String email;
  final String createdAt;
  final String status;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xffF8F9FA),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 25,
            backgroundColor: Color(0xffF1F3F5),
            child: Icon(Icons.person, color: Colors.grey, size: 25),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  email,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_today_outlined,
                      size: 12,
                      color: Color(kprimarycolor),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      createdAt,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(kprimarycolor),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  status,
                  style: const TextStyle(
                    color: Colors.green,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              PopupMenuButton<String>(
                color: Colors.white,
                padding: EdgeInsets.zero,
                elevation: 0,
                icon: const Icon(Icons.more_vert, color: Colors.grey),
                onSelected: (value) {
                  if (value == 'orders') {
                  } else if (value == 'edit') {
                  } else if (value == 'block') {
                  } else if (value == 'delete') {}
                },
                itemBuilder: (context) => [
                  buildPopupMenuItem(
                    context,
                    value: 'orders',
                    text: 'Orders',
                    icon: Icons.shopping_bag_outlined,
                    color: Colors.blue,
                  ),
                  buildPopupMenuItem(
                    context,
                    value: 'edit',
                    text: 'Edit',
                    icon: Icons.edit_outlined,
                    color: Colors.green,
                  ),
                  buildPopupMenuItem(
                    context,
                    value: 'block',
                    text: 'Block User',
                    icon: Icons.block_outlined,
                    color: Colors.orange,
                  ),
                  const PopupMenuDivider(),
                  buildPopupMenuItem(
                    context,
                    value: 'delete',
                    text: 'Delete',
                    icon: Icons.delete_outline,
                    color: Colors.red,
                    textColor: Colors.red,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  PopupMenuItem<String> buildPopupMenuItem(
    BuildContext context, {
    required String value,
    required String text,
    required IconData icon,
    required Color color,
    Color? textColor,
  }) {
    return PopupMenuItem<String>(
      value: value,
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 10),
          Text(text, style: TextStyle(color: textColor ?? Colors.black)),
        ],
      ),
    );
  }
}
