import 'package:flutter/material.dart';
import 'package:tawfeer_market/widgets/categories_card.dart';
import 'package:tawfeer_market/widgets/custom_text_field.dart';

class ManageCategoriesView extends StatelessWidget {
  const ManageCategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          SearchBar(),
          const SizedBox(height: 10),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.72,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
              ),
              itemCount: 8,
              itemBuilder: (context, index) {
                return const CategoriesCard();
              },
            ),
          ),
        ],
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      labelText: 'Search Category...',
      prefixIcon: Icons.search_rounded,
      borderRadius: 20,
    );
  }
}

