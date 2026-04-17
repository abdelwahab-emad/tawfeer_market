import 'package:flutter/material.dart';
import 'package:tawfeer_market/widgets/custom_text_field.dart';

class ProductsView extends StatelessWidget {
  const ProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SearchBar(),
          ],
        ),
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      labelText: 'Search Products...',
      prefixIcon: Icons.search_rounded,
      borderRadius: 20,
      
    );
  }
}
