import 'package:flutter/material.dart';
import 'package:tawfeer_market/constants.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    super.key,
    required this.name,
    required this.image,
    required this.price,
    required this.oldPrice,
    required this.hasDiscount,
    this.onTap,
    this.showBorder = true,
    this.showAddButton = true,
  });

  final String name;
  final String image;
  final String price;
  final String oldPrice;
  final bool hasDiscount;
  final void Function()? onTap;
  final bool showBorder;
  final bool showAddButton;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: showBorder
              ? Border.all(color: Colors.grey.withOpacity(0.2))
              : null,
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Center(
                      child: Image.network(image, fit: BoxFit.contain),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '$price EGP',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      hasDiscount
                          ? Text(
                              '$oldPrice EGP',
                              style: const TextStyle(
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough,
                                fontSize: 12,
                              ),
                            )
                          : const SizedBox(),
                    ],
                  ),
                  const SizedBox(height: 45),
                ],
              ),
            ),
            const Positioned(
              top: 10,
              right: 10,
              child: Icon(Icons.favorite_border, color: Color(kprimarycolor)),
            ),

            if (showAddButton)
              Positioned(
                bottom: 10,
                right: 10,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Color(kprimarycolor),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(Icons.add, color: Colors.white),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
