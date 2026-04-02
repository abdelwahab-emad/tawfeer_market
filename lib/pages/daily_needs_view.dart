import 'package:flutter/material.dart';
import 'package:tawfeer_market/widgets/product_item.dart';

class DailyNeedsView extends StatelessWidget {
  const DailyNeedsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 10),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: const Text(
              'Daily Needs',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 10,),
          SizedBox(
            height: 280,
            child: GridView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                mainAxisSpacing: 15,
                crossAxisSpacing: 10,
                childAspectRatio: 1.3,
              ),
              itemBuilder: (context, index) {
                return const ProductItem(
                  image: 'assets/lepton.jpeg',
                  price: '11.5',
                  oldPrice: '11.95',
                  name: 'Lipton Dust Tea 40gm',
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
