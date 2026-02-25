import 'package:flutter/material.dart';
import 'package:tawfeer_market/constants.dart';

class CustomButton extends StatelessWidget {
  CustomButton({super.key, required this.onTap, required this.text});

  String text;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Color(kprimarycolor), width: 2),
          ),
          height: 45,
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: Color(0xFF001D3D),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
