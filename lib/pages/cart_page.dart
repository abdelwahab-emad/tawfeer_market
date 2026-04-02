import 'package:flutter/material.dart';
import 'package:tawfeer_market/pages/empty_card_view.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  static String id = 'cart_page';
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return EmptyCardView();
  }
}

