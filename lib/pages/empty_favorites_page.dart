import 'package:flutter/material.dart';

class EmptyFavoritesPage extends StatelessWidget {
  const EmptyFavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/favouritePhoto.jpeg'),
        const Text(
          'You have no items added into the list',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16
          ),
        ),
      ],
    );
  }
}
