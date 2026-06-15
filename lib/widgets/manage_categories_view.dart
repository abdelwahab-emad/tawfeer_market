import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tawfeer_market/constants.dart';
import 'package:tawfeer_market/cubits/category_cubit/category_cubit.dart';
import 'package:tawfeer_market/pages/edit_category_page.dart';
import 'package:tawfeer_market/widgets/categories_card.dart';
import 'package:tawfeer_market/widgets/custom_text_field.dart';
import 'package:tawfeer_market/widgets/delete_category_sheet.dart';

class ManageCategoriesView extends StatefulWidget {
  const ManageCategoriesView({super.key});

  @override
  State<ManageCategoriesView> createState() => _ManageCategoriesViewState();
}

class _ManageCategoriesViewState extends State<ManageCategoriesView> {
  String searchQuery = '';
  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        if (state is CategoryLoading) {
          return const Center(
            child: CircularProgressIndicator(color: Color(kprimarycolor)),
          );
        }

        if (state is CategoryError) {
          return Center(child: Text(state.message));
        }

        if (state is CategorySuccess) {
         final filteredCategories = state.categoriesList.where((category) {
            return category.name
                .toLowerCase()
                .contains(searchQuery.toLowerCase());
          }).toList();
          return Column(
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
                child: filteredCategories.isEmpty
                    ? const Center(child: Text("No categories found"))
                    : GridView.builder(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.72,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15,
                        ),
                        itemCount: filteredCategories.length,
                        itemBuilder: (context, index) {
                          final category = filteredCategories[index];

                    return CategoriesCard(
                      name: category.name,
                      imageUrl: category.imageUrl,
                      onDelete: () {
                        showModalBottomSheet(
                          context: context,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(30),
                            ),
                          ),
                          builder: (context) =>
                              DeleteCategorySheet(docId: category.id),
                        );
                      },
                      onEdit: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditCategoryPage(name: category.name, imageUrl: category.imageUrl, docId: category.id,),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          );
        }
        return const SizedBox();
      },
    );
  }
}

class SearchBar extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const SearchBar({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      labelText: 'Search Category...',
      prefixIcon: Icons.search_rounded,
      borderRadius: 20,
      onChanged: onChanged,
    );
  }
}
