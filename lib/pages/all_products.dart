import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tawfeer_market/cubits/bottom_nav_cubit/bottom_nav_cubit.dart';
import 'package:tawfeer_market/cubits/product_cubit/product_cubit.dart';
import 'package:tawfeer_market/l10n/app_localizations.dart';
import 'package:tawfeer_market/pages/product_details_page.dart';
import 'package:tawfeer_market/pages/user_main_layout_page.dart';
import 'package:tawfeer_market/widgets/product_item.dart';

class AllProducts extends StatelessWidget {
  const AllProducts({super.key});

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;

    return BlocProvider(
      create: (context) => ProductCubit()..getAllProducts(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          scrolledUnderElevation: 0.0,
          title: Text(
            locale.allProducts,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          centerTitle: true,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
          actions: [
            Padding(
              padding: const EdgeInsetsDirectional.only(end: 16),
              child: IconButton(
                onPressed: () {
                  context.read<BottomNavCubit>().changeIndex(1);
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const UserMainLayout()),
                    (route) => false,
                  );
                },
                icon: const Icon(Icons.shopping_cart, color: Colors.black),
              ),
            ),
          ],
        ),
        body: BlocBuilder<ProductCubit, ProductState>(
          builder: (context, state) {
            if (state is ProductLoading) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.orange),
              );
            } else if (state is ProductSuccess) {
              return Directionality(
                textDirection: TextDirection.rtl,
                child: GridView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: state.products.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.6,
                  ),
                  itemBuilder: (context, index) {
                    final product = state.products[index];
                    return Directionality(
                      textDirection: Directionality.of(context),
                      child: ProductItem(
                        name: product.name,
                        image: product.imageUrl,
                        price: product.price.toString(),
                        oldPrice: product.oldPrice.toString(),
                        hasDiscount: product.hasDiscount,
                        id: product.id,
                        type: product.type,
                        stock: product.stock,
                        categoryId: product.categoryId,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ProductDetailsPage(product: product),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              );
            } else if (state is ProductError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}