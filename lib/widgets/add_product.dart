import 'package:flutter/material.dart';

class AddProduct extends StatelessWidget {
  final VoidCallback onPressed;

  const AddProduct({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: Colors.orange,
      child: const Icon(
        Icons.add,
        color: Colors.white,
        size: 30,
      ),
    );
  }
}