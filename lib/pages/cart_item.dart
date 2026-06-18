import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tawfeer_market/constants.dart';
import 'package:tawfeer_market/cubits/cart/cart_cubit.dart';
import 'package:tawfeer_market/models/product_model.dart';
import 'package:tawfeer_market/widgets/custom_snackbar.dart';
import 'package:tawfeer_market/widgets/delete_from_cart_page.dart';

class CartItem extends StatelessWidget {
  const CartItem({super.key, required this.product});

  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    final int currentQuantity = product.quantity ?? 1;
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            spreadRadius: 1,
            blurRadius: 8,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: NetworkImage(product.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Text(
                  '${product.price} EGP',
                  style: const TextStyle(
                    color: Color(kprimarycolor),
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.transparent,
                    builder: (context) => DeleteFromCartSheet(product: product),
                  );
                },
                child: const Icon(
                  Icons.delete_outline,
                  color: Colors.red,
                  size: 24,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(kprimarycolor).withOpacity(0.05),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        if (currentQuantity > 1) {
                          context.read<CartCubit>().updateQuantity(
                            productId: product.id,
                            quantity: currentQuantity - 1,
                          );
                        }
                      },
                      child: const Icon(
                        Icons.remove,
                        size: 20,
                        color: Color(kprimarycolor),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        '${currentQuantity}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        bool isUpdated = await context
                            .read<CartCubit>()
                            .updateQuantity(
                              productId: product.id,
                              quantity: currentQuantity + 1,
                            );
                        if (!isUpdated && context.mounted) {
                          showCustomSnackBar(
                            context,
                            'Sorry, maximum available stock reached!',
                            color: Colors.red,
                          );
                        }
                      },
                      child: const Icon(
                        Icons.add,
                        size: 20,
                        color: Color(kprimarycolor),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
