import 'package:flutter/material.dart';
import 'package:tawfeer_market/constants.dart';

class CustomButton extends StatelessWidget {
  CustomButton({
    super.key,
    required this.onTap, 
    required this.text, 
    required this.textColor, 
    required this.filledColor,
    this.borderColor = const Color(kprimarycolor),
  });

  String text;
  Color textColor;
  Color filledColor;
  Color borderColor;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: filledColor,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: borderColor, width: 2.5),
        ),
        height: 55,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
