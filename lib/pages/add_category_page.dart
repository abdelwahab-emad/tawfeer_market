import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tawfeer_market/constants.dart';
import 'package:tawfeer_market/cubits/add_category/add_category_cubit.dart';
import 'package:tawfeer_market/widgets/custom_admin_app_bar.dart';
import 'package:tawfeer_market/widgets/custom_button.dart';
import 'package:tawfeer_market/widgets/custom_snackbar.dart';
import 'package:tawfeer_market/widgets/custom_text_field.dart';

class AddCategoryPage extends StatefulWidget {
  const AddCategoryPage({super.key});

  @override
  State<AddCategoryPage> createState() => _AddCategoryPageState();
}

class _AddCategoryPageState extends State<AddCategoryPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddCategoryCubit, AddCategoryState>(
      listener: (context, state) {
        if (state is AddCategorySuccess) {
          showCustomSnackBar(
            context,
            'Category added successfully',
            color: Colors.green,
          );
          Future.delayed(const Duration(milliseconds: 300), () {
            context.read<AddCategoryCubit>().clearImage();
            Navigator.pop(context);
          });
        }
        if (state is AddCategoryFailure) {
          showCustomSnackBar(context, state.errMessage);
        }
      },
      builder: (context, state) {
        final cubit = context.read<AddCategoryCubit>();

        final imageFile = cubit.selectedImage;

        return Scaffold(
          backgroundColor: const Color(0xFFF8F9FA),
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(70),
            child: CustomAdminAppBar(
              title: 'Add Category',
              actionIcon: IconButton(
                icon: const Icon(Icons.category, color: Colors.black),
                onPressed: () {},
              ),
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      cubit.pickImage();
                    },
                    child: Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.grey.withOpacity(0.3)),
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

                  const SizedBox(height: 30),

                  CustomTextField(
                    controller: nameController,
                    labelText: 'Category Name',
                    prefixIcon: Icons.category_outlined,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Category name is required";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 30),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: state is AddCategoryLoading
                        ? const CircularProgressIndicator(
                            color: Color(kprimarycolor),
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
                              cubit.addCategory(name: nameController.text);
                            },
                            text: 'Add Category',
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
