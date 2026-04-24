import 'package:flutter/material.dart';

class AddItem extends StatelessWidget {
  final VoidCallback onPressed;

  const AddItem({super.key, required this.onPressed});

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