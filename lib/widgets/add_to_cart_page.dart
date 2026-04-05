import 'package:flutter/material.dart';
import 'package:tawfeer_market/constants.dart';
import 'package:tawfeer_market/widgets/custom_button.dart';

class AddToCartPage extends StatelessWidget {
  const AddToCartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      height: 180,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Are you sure you want to add this item to your cart?',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 30,),
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  onTap: () => Navigator.pop(context), 
                  text: 'Not Now', 
                  textColor: Color(kprimarycolor), 
                  filledColor: Colors.white,
                ),
              ),
              const SizedBox(width: 20,),
              Expanded(
                child: CustomButton(
                  onTap: () => Navigator.pop(context), 
                  text: 'Add To Cart', 
                  textColor: Colors.white, 
                  filledColor: Color(kprimarycolor),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
