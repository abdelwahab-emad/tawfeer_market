import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tawfeer_market/constants.dart';
import 'package:tawfeer_market/cubits/product_cubit/product_cubit.dart';
import 'package:tawfeer_market/pages/product_details_page.dart';
import 'package:tawfeer_market/widgets/product_item.dart';

class DailyNeedsView extends StatelessWidget {
  const DailyNeedsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductCubit()..getProductsByType('daily'),
      child: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          Widget content;
          if (state is ProductLoading) {
            content = const Center(
              child: CircularProgressIndicator(color: Color(kprimarycolor)),
            );
          } else if (state is ProductSuccess) {
            content = GridView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                mainAxisSpacing: 15,
                crossAxisSpacing: 10,
                childAspectRatio: 1.3,
              ),
              itemBuilder: (context, index) {
                final product = state.products[index];
                return ProductItem(
                  image: product.imageUrl,
                  price: product.price.toString(),
                  oldPrice: product.oldPrice.toString(),
                  name: product.name,
                  hasDiscount: product.hasDiscount,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ProductDetailsPage(product: product),
                      ),
                    );
                  },
                );
              },
            );
          } else if (state is ProductError) {
            content = Center(child: Text(state.message));
          } else {
            content = const Center(child: Text('No products found'));
          }

          return Padding(
            padding: const EdgeInsets.only(left: 16, right: 10),
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Daily Needs',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(height: 280, child: content),
              ],
            ),
          );
        },
      ),
    );
  }
}
