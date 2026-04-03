import 'package:flutter/material.dart';
import 'package:tawfeer_market/pages/full_cart_view.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  static String id = 'cart_page';
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, 
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0.0,
        title: const Text('My Cart', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0,
      ),
      body: FullCartView(),
    );
  }
}



