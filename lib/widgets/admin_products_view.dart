import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tawfeer_market/constants.dart';
import 'package:tawfeer_market/cubits/product_cubit/product_cubit.dart';
import 'package:tawfeer_market/pages/edit_product_page.dart';
import 'package:tawfeer_market/widgets/custom_text_field.dart';
import 'package:tawfeer_market/widgets/delete_product_sheet.dart';
import 'package:tawfeer_market/widgets/product_card.dart';

class AdminProductsView extends StatefulWidget {
  const AdminProductsView({super.key});

  @override
  State<AdminProductsView> createState() => _AdminProductsViewState();
}

class _AdminProductsViewState extends State<AdminProductsView> {
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    context.read<ProductCubit>().getAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SearchBar(
            onChanged: (value) {
              setState(() {
                searchQuery = value;
              });
            },
          ),
          const SizedBox(height: 10),
          Expanded(
            child: BlocBuilder<ProductCubit, ProductState>(
              builder: (context, state) {
                if (state is ProductLoading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Color(kprimarycolor),
                    ),
                  );
                }
                if (state is ProductError) {
                  return Center(child: Text(state.message));
                }
                if (state is ProductSuccess) {
                  final filteredProducts = state.products.where((product) {
                    return product.name.toLowerCase().contains(
                      searchQuery.toLowerCase(),
                    );
                  }).toList();
                  if (filteredProducts.isEmpty) {
                    return const Center(child: Text("No products found"));
                  }
                  return GridView.builder(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 16),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.72,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15,
                        ),
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, index) {
                      return ProductCard(
                        product: filteredProducts[index],
                        onDelete: () {
                          showModalBottomSheet(
                            context: context,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(30),
                              ),
                            ),
                            builder: (context) =>
                                DeleteProductSheet(docId: filteredProducts[index].id),
                          );
                        },
                        onEdit: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  EditProductPage(product: filteredProducts[index]),
                            ),
                          );
                        },
                      );
                    },
                  );
                }
                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({super.key, required this.onChanged});

  final ValueChanged<String> onChanged;
  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      labelText: 'Search Products...',
      prefixIcon: Icons.search_rounded,
      borderRadius: 20,
      onChanged: onChanged,
    );
  }
}
