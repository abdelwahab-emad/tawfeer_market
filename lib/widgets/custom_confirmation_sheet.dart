import 'package:flutter/material.dart';
import 'package:tawfeer_market/constants.dart';
import 'package:tawfeer_market/widgets/custom_button.dart';

class CustomConfirmationSheet extends StatelessWidget {
  const CustomConfirmationSheet({
    super.key,
    required this.message,
    required this.leftButtonText,
    required this.rightButtonText,
    required this.onLeftTap,
    required this.onRightTap,
    this.isLoading = false,
    this.messageColor = Colors.grey,
  });

  final String message;
  final String leftButtonText;
  final String rightButtonText;
  final VoidCallback onLeftTap;
  final VoidCallback onRightTap;
  final bool isLoading;
  final Color messageColor;


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      height: 180,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              color: messageColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 30),
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  onTap: onLeftTap,
                  text: leftButtonText,
                  textColor: const Color(kprimarycolor),
                  filledColor: Colors.white,
                  borderWidth: 1.5,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Color(kprimarycolor),
                        ),
                      )
                    : CustomButton(
                        onTap: onRightTap,
                        text: rightButtonText,
                        textColor: Colors.white,
                        filledColor: const Color(kprimarycolor),
                        borderWidth: 1,
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}