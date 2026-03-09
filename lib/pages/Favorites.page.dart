import 'package:flutter/material.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  static String id = 'Favorite_Page';
  @override
  State<FavoritesPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
    );
  }
}