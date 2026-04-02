import 'package:flutter/material.dart';
import 'package:tawfeer_market/constants.dart';
import 'package:tawfeer_market/pages/cart_item.dart';
import 'package:tawfeer_market/widgets/custom_button.dart';

class FullCartView extends StatelessWidget {
  const FullCartView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: 8, 
            itemBuilder: (context, index) {
              return const CartItem(); 
            },
          ),
        ),
    
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.15),
                spreadRadius: 1,
                blurRadius: 10,
                offset: const Offset(0, -5), 
              ),
            ],
          ),
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Subtotal', style: TextStyle(color: Colors.grey, fontSize: 16)),
                  Text('46.0 EGP', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 10),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text(
                    '46.0 EGP',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(kprimarycolor)),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              
              CustomButton(
                onTap: () {},
                text: 'Confirm Order',
                textColor: Colors.white,
                filledColor: const Color(kprimarycolor),
                borderRadius: 30, 
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
        ),
      ],
    );
  }
}