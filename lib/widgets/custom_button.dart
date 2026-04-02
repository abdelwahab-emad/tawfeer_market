import 'package:flutter/material.dart';
import 'package:tawfeer_market/constants.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onTap, 
    required this.text, 
    required this.textColor, 
    required this.filledColor,
    this.borderColor = const Color(kprimarycolor),
    this.width = double.infinity,
    this.borderRadius = 15,
    this.icon,
    this.borderWidth = 2.5,
    this.fontWeight = FontWeight.bold,
  });

  final String text;
  final Color textColor;
  final Color filledColor;
  final Color borderColor;
  final void Function() onTap;
  final double width;
  final IconData? icon;
  final double borderRadius;
  final double borderWidth;
  final FontWeight fontWeight;
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: filledColor,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(color: borderColor, width: borderWidth),
        ),
        height: 55,
        width: width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, color: textColor),
              const SizedBox(width: 10),
            ],
            Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: 20,
                fontWeight: fontWeight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
