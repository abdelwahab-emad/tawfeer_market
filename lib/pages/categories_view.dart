import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tawfeer_market/constants.dart';
import 'package:tawfeer_market/cubits/category_cubit/category_cubit.dart';
import 'package:tawfeer_market/widgets/category_item.dart';

class CategoriesView extends StatelessWidget {
  const CategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Color(kprimarycolor).withOpacity(0.05),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsetsGeometry.only(left: 16, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Categories',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'View All Products',
                    style: TextStyle(
                      color: Color(kprimarycolor),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      decoration: TextDecoration.underline,
                      decorationColor: Color(kprimarycolor),
                      decorationThickness: 2,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 10, 10),
            child: BlocBuilder<CategoryCubit, CategoryState>(
              builder: (context, state) {
                if (state is CategoryLoading) {
                  return const SizedBox(
                    height: 280,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Color(kprimarycolor),
                      ),
                    ),
                  );
                } else if (state is CategorySuccess) {
                  print("✅ عدد الأقسام اللي وصلت: ${state.categoriesList.length}");
                  return SizedBox(
                    height: 280,
                    child: GridView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.categoriesList.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 15,
                            crossAxisSpacing: 10,
                            childAspectRatio: 1.3,
                          ),
                      itemBuilder: (context, index) {
                        var category = state.categoriesList[index];
                        return CategoryItem(
                          image: category.imageUrl,
                          label: category.name,
                        );
                      },
                    ),
                  );
                } else if (state is CategoryError) {
                  return SizedBox(
                    height: 280,
                    child: Center(
                      child: Text(
                        state.message,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  );
                }
                return const SizedBox(height: 280);
              },
            ),
          ),
        ],
      ),
    );
  }
}
