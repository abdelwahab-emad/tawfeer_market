import 'package:flutter/material.dart';
import 'package:tawfeer_market/pages/favorites_item.dart';

class FullFavoritesView extends StatelessWidget {
  const FullFavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: 8,
            itemBuilder: (context, index){
              return const FavoritesItem();
            }
          ), 
        ),
      ],
    );
  }
}