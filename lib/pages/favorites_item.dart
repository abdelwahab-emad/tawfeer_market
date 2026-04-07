import 'package:flutter/material.dart';
import 'package:tawfeer_market/constants.dart';
import 'package:tawfeer_market/models/product_model.dart';
import 'package:tawfeer_market/widgets/add_to_cart_page.dart';
import 'package:tawfeer_market/widgets/favorite_button.dart';

class FavoritesItem extends StatelessWidget {
  const FavoritesItem({super.key, required this.product});

  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white),
      child: Row(
        children: [
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.grey.withOpacity(0.3),
                width: 1.0,
              ),
            ),
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Image.network(product.imageUrl, fit: BoxFit.contain),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: TextStyle(fontWeight: FontWeight.bold),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Text(
                  '${product.price} EGP',
                  style: TextStyle(
                    color: Color(kprimarycolor),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(30),
                        ),
                      ),
                      builder: (context) => AddToCartPage(product: product),
                    );
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    alignment: Alignment.centerLeft,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    'Add to cart',
                    style: TextStyle(
                      color: Color(kprimarycolor),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          FavoriteButton(product: product),
        ],
      ),
    );
  }
}
