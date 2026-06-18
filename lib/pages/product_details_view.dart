import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tawfeer_market/constants.dart';
import 'package:tawfeer_market/cubits/product_cubit/product_cubit.dart';
import 'package:tawfeer_market/l10n/app_localizations.dart';
import 'package:tawfeer_market/models/product_model.dart';
import 'package:tawfeer_market/pages/product_details_page.dart';
import 'package:tawfeer_market/widgets/add_to_cart_page.dart';
import 'package:tawfeer_market/widgets/custom_button.dart';
import 'package:tawfeer_market/widgets/favorite_button.dart';
import 'package:tawfeer_market/widgets/product_item.dart';

class ProductDetailsView extends StatelessWidget {
  const ProductDetailsView({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 250,
                  width: double.infinity,
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Center(
                    child: Image.network(product.imageUrl, fit: BoxFit.contain),
                  ),
                ),
                Positioned(
                  top: 15,
                  right: 15,
                  child: FavoriteButton(product: product),
                ),
              ],
            ),
            const SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Text(
                        '${product.price} ${locale.currency}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Color(kprimarycolor),
                        ),
                      ),
                      const SizedBox(width: 15),
                      if (product.hasDiscount)
                        Text(
                          '${product.oldPrice} ${locale.currency}',
                          style: const TextStyle(
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                            fontSize: 18,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  CustomButton(
                    onTap: () {
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
                    text: locale.addToCart,
                    textColor: Colors.white,
                    filledColor: const Color(kprimarycolor),
                    borderRadius: 30,
                  ),
                  const SizedBox(height: 25),
                  Text(
                    locale.relatedProducts,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    height: 250,
                    child: BlocBuilder<ProductCubit, ProductState>(
                      builder: (context, state) {
                        if (state is ProductLoading) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Color(kprimarycolor),
                            ),
                          );
                        } else if (state is ProductSuccess) {
                          final related = state.products
                              .where((p) => p.id != product.id)
                              .toList();

                          if (related.isEmpty) {
                            return Center(
                              child: Text(locale.noRelatedProducts),
                            );
                          }

                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: related.length,
                            itemBuilder: (context, index) {
                              final relatedProduct = related[index];
                              return Padding(
                                padding: const EdgeInsets.only(right: 12),
                                child: SizedBox(
                                  width: 160,
                                  child: ProductItem(
                                    image: relatedProduct.imageUrl,
                                    price: relatedProduct.price.toString(),
                                    oldPrice: relatedProduct.oldPrice.toString(),
                                    name: relatedProduct.name,
                                    hasDiscount: relatedProduct.hasDiscount,
                                    id: relatedProduct.id,
                                    type: relatedProduct.type,
                                    stock: relatedProduct.stock,
                                    categoryId: relatedProduct.categoryId,
                                    onTap: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ProductDetailsPage(
                                            product: relatedProduct,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              );
                            },
                          );
                        } else if (state is ProductError) {
                          return Center(child: Text(state.message));
                        }
                        return const SizedBox();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}