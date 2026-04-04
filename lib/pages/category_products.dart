import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tawfeer_market/cubits/product_cubit/product_cubit.dart';
import 'package:tawfeer_market/cubits/bottom_nav_cubit/bottom_nav_cubit.dart';
import 'package:tawfeer_market/pages/category_products_view.dart';

class CategoryProducts extends StatelessWidget {
  const CategoryProducts({
    super.key,
    required this.categoryName,
    required this.categoryId,
  });

  final String categoryName;
  final String categoryId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductCubit()..getProductsByCategoryId(categoryId: categoryId),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          scrolledUnderElevation: 0.0,
          title: Text(
            categoryName,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          centerTitle: true,
          elevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: IconButton(
                onPressed: () {
                  BlocProvider.of<BottomNavCubit>(context).changeIndex(1);
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.shopping_cart, color: Colors.black),
              ),
            ),
          ],
        ),
        body: const CategoryProductsView(),
      ),
    );
  }
}