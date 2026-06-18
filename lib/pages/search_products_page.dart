import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tawfeer_market/cubits/product_cubit/product_cubit.dart';
import 'package:tawfeer_market/models/product_model.dart';
import 'package:tawfeer_market/pages/product_details_page.dart';
import 'package:tawfeer_market/widgets/custom_text_field.dart';
import 'package:tawfeer_market/widgets/product_item.dart';

class SearchProductPage extends StatefulWidget {
  const SearchProductPage({super.key});

  static String id = 'SearchProductPage';

  @override
  State<SearchProductPage> createState() => _SearchProductPageState();
}

class _SearchProductPageState extends State<SearchProductPage> {
  final TextEditingController searchController = TextEditingController();
  List<ProductModel> filteredProducts = [];
  List<ProductModel> allProducts = [];

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void filterProducts(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredProducts = [];
      } else {
        filteredProducts = allProducts
            .where((product) =>
                product.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductCubit()..getAllProducts(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          scrolledUnderElevation: 0.0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          titleSpacing: 0,
          title: Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CustomTextField(
              controller: searchController,
              onChanged: filterProducts,
              labelText: 'Search in Tawfeer Market...',
              prefixIcon: Icons.search_rounded,
              prefixIconSize: 26.0,
              borderRadius: 30.0,
              horizontalPadding: false,
              focusColor: const Color(0xFFF1F3F5),
            ),
          ),
        ),
        body: BlocBuilder<ProductCubit, ProductState>(
          builder: (context, state) {
            if (state is ProductLoading) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.orange),
              );
            } else if (state is ProductSuccess) {
              if (allProducts.isEmpty) {
                allProducts = state.products;
              }

              if (searchController.text.isEmpty || filteredProducts.isEmpty) {
                return const Center(
                  child: Image(
                    image: AssetImage('assets/notresultsfound.jpeg'),
                    fit: BoxFit.contain,
                  ),
                );
              }

              return GridView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: filteredProducts.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 10,
                  childAspectRatio: 0.6,
                ),
                itemBuilder: (context, index) {
                  final product = filteredProducts[index];
                  return ProductItem(
                    name: product.name,
                    image: product.imageUrl,
                    price: product.price.toString(),
                    oldPrice: product.oldPrice.toString(),
                    hasDiscount: product.hasDiscount,
                    id: product.id,
                    type: product.type,
                    categoryId: product.categoryId,
                    stock: product.stock,
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
              return Center(child: Text(state.message));
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}