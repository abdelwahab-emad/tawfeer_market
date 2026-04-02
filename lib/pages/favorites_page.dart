import 'package:flutter/material.dart';
import 'package:tawfeer_market/pages/empty_favorites_page.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  static String id = 'favorites_page';
  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, 
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Favorites', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0,
      ),
      body: EmptyFavoritesPage(),
    );
  }
}