import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tawfeer_market/constants.dart';
import 'package:tawfeer_market/cubits/product_cubit/product_cubit.dart';
import 'package:tawfeer_market/pages/product_details_page.dart';
import 'package:tawfeer_market/widgets/product_item.dart';

class CategoryProductsView extends StatelessWidget {
  const CategoryProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      
      child: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return const Center(child: CircularProgressIndicator(color: Color(kprimarycolor),),);
          } else if (state is ProductSuccess) {
            if(state.products.isEmpty){
              return const Center(
                child: Image(image: AssetImage('assets/notresultsfound.jpeg')),
              );
            }
            return GridView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 15,
                crossAxisSpacing: 10,
                childAspectRatio: 0.55,
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
                        builder: (context) => ProductDetailsPage(
                          product: product,
                        ),
                      ),
                    );
                  },
                );
              },
            );
          } else if (state is ProductError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox();
        },
      ),
    );
  }
}
