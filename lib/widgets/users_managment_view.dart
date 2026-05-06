import 'package:flutter/material.dart';
import 'package:tawfeer_market/widgets/custom_text_field.dart';
import 'package:tawfeer_market/widgets/user_list_item.dart';
import 'package:tawfeer_market/widgets/users_count_card.dart';

class UsersManagmentView extends StatelessWidget {
  const UsersManagmentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SearchBar(),
          const SizedBox(height: 10),
          UsersCountCard(),
          const SizedBox(height: 10),
          UserListItem(),
        ],
      ),
    );
  }
}



class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      labelText: 'Search Users by name or email...',
      prefixIcon: Icons.search_rounded,
      borderRadius: 20,
    );
  }
}
