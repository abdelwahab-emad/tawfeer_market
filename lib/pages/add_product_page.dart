import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tawfeer_market/constants.dart';
import 'package:tawfeer_market/cubits/add_product/add_product_cubit.dart';
import 'package:tawfeer_market/cubits/category_cubit/category_cubit.dart';
import 'package:tawfeer_market/models/category_model.dart';
import 'package:tawfeer_market/widgets/custom_admin_app_bar.dart';
import 'package:tawfeer_market/widgets/custom_button.dart';
import 'package:tawfeer_market/widgets/custom_drop_down_field.dart';
import 'package:tawfeer_market/widgets/custom_snackbar.dart';
import 'package:tawfeer_market/widgets/custom_text_field.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController discountController = TextEditingController();
  final TextEditingController stockController = TextEditingController();

  CategoryModel? selectedCategory;
  String? selectedType;

  final List<String> types = ['Daily Needs', 'Bulk', 'Top Selling', 'other'];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddProductCubit, AddProductState>(
      listener: (context, state) {
        if (state is AddProductSuccess) {
          showCustomSnackBar(
            context,
            'Product added successfully',
            color: Colors.green,
          );
          Future.delayed(const Duration(milliseconds: 300), () {
            context.read<AddProductCubit>().clearImage();
            Navigator.pop(context);
          });
        }
        if (state is AddProductFailure) {
          showCustomSnackBar(context, state.errMessage);
        }
      },
      builder: (context, state) {
        final cubit = context.read<AddProductCubit>();
        final imageFile = cubit.selectedImage;
        final categoryState = context.read<CategoryCubit>().state;
        List<CategoryModel> categories = [];
        if (categoryState is CategorySuccess) {
          categories = categoryState.categoriesList;
        }

        return Scaffold(
          backgroundColor: const Color(0xFFF8F9FA),
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(70),
            child: CustomAdminAppBar(
              title: 'Add New Product',
              actionIcon: IconButton(
                icon: const Icon(
                  Icons.filter_list_rounded,
                  color: Colors.black,
                ),
                onPressed: () {},
              ),
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        cubit.pickImage();
                      },
                      child: Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.grey.withOpacity(0.3),
                          ),
                        ),
                        child: imageFile != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.file(
                                  imageFile,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
                                ),
                              )
                            : const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add_a_photo_outlined,
                                    size: 40,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    'Upload Image',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  CustomTextField(
                    controller: nameController,
                    labelText: 'Product Name',
                    prefixIcon: Icons.shopping_bag_outlined,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Product name is required";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),

                  CustomDropdownField<CategoryModel>(
                    labelText: 'Category',
                    items: categories,
                    prefixIcon: Icons.category_outlined,
                    value: selectedCategory,
                    itemLabel: (c) => c.name,
                    onChanged: (value) {
                      setState(() {
                        selectedCategory = value;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return "Category is requeird";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),

                  CustomDropdownField<String>(
                    labelText: 'Product Type',
                    items: types,
                    prefixIcon: Icons.label_important_outline_rounded,
                    value: selectedType,
                    itemLabel: (t) => t,
                    onChanged: (value) {
                      setState(() {
                        selectedType = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Product type is requeird";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            controller: priceController,
                            labelText: 'Price',
                            prefixIcon: Icons.attach_money_rounded,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp(r'^\d+\.?\d{0,2}'),
                              ),
                            ],
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "required";
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: CustomTextField(
                            controller: discountController,
                            labelText: 'Discount %',
                            prefixIcon: Icons.percent_rounded,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp(r'^\d+\.?\d{0,2}'),
                              ),
                            ],
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "required";
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 15),
                  CustomTextField(
                    controller: stockController,
                    labelText: 'Initial Stock (Quantity)',
                    prefixIcon: Icons.inventory_2_outlined,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Initial stock is required";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: state is AddProductLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Color(kprimarycolor),
                            ),
                          )
                        : CustomButton(
                            onTap: () {
                              if (!formKey.currentState!.validate()) return;
                              if (imageFile == null) {
                                showCustomSnackBar(
                                  context,
                                  'Please select image',
                                );
                                return;
                              }
                              cubit.addProduct(
                                name: nameController.text,
                                categoryId: selectedCategory!.id,
                                price: double.parse(priceController.text),
                                discount: double.parse(discountController.text),
                                initialStock: int.parse(stockController.text),
                                type: selectedType!,
                              );
                            },

                            text: 'Add Product',
                            textColor: Colors.white,
                            filledColor: Color(kprimarycolor),
                          ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
