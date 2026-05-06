
import 'package:flutter/material.dart';
import 'package:tawfeer_market/widgets/user_list_item.dart';

class UsersListView extends StatelessWidget {
  const UsersListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return const UserListItem();
      },
    );
  }
}