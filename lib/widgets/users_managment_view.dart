import 'package:flutter/material.dart';
import 'package:tawfeer_market/widgets/custom_text_field.dart';
import 'package:tawfeer_market/widgets/users_count_card.dart';
import 'package:tawfeer_market/widgets/users_list_view.dart';

class UsersManagmentView extends StatefulWidget {
  const UsersManagmentView({super.key});

  @override
  State<UsersManagmentView> createState() => _UsersManagmentViewState();
}

class _UsersManagmentViewState extends State<UsersManagmentView> {
  String searchQuery = '';
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SearchBar(
            onChanged: (value) {
              setState(() {
                searchQuery = value;
              });
            },
          ),
          const SizedBox(height: 10),
          UsersCountCard(),
          const SizedBox(height: 10),
          Expanded(child: UsersListView(searchQuery: searchQuery)),
        ],
      ),
    );
  }
}


class SearchBar extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const SearchBar({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      labelText: 'Search Users by name or email...',
      prefixIcon: Icons.search_rounded,
      borderRadius: 20,
      onChanged: onChanged,
    );
  }
}
