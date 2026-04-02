import 'package:flutter/material.dart';
import 'package:tawfeer_market/widgets/product_item.dart';

class BulkView extends StatelessWidget {
  const BulkView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 10),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: const Text(
              'Bulk',
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
                  image: 'assets/Nescafe.jpeg',
                  price: '389.95',
                  oldPrice: '404.95',
                  name: 'Nescafe Gold Instant Coffee Pouch 190gm',
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
