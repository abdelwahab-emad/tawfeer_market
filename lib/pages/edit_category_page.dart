import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tawfeer_market/constants.dart';
import 'package:tawfeer_market/cubits/add_category/add_category_cubit.dart';
import 'package:tawfeer_market/widgets/custom_admin_app_bar.dart';
import 'package:tawfeer_market/widgets/custom_button.dart';
import 'package:tawfeer_market/widgets/custom_snackbar.dart';
import 'package:tawfeer_market/widgets/custom_text_field.dart';

class EditCategoryPage extends StatefulWidget {
  const EditCategoryPage({
    super.key,
    required this.name,
    required this.imageUrl,
    required this.docId,
  });
  final String name;
  final String imageUrl;
  final String docId;

  @override
  State<EditCategoryPage> createState() => _AddCategoryPageState();
}

class _AddCategoryPageState extends State<EditCategoryPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.name;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddCategoryCubit, AddCategoryState>(
      listener: (context, state) {
        if (state is UpdateCateogrySuccess) {
          showCustomSnackBar(
            context,
            'Category updated successfully',
            color: Colors.green,
          );
          Navigator.pop(context);
          context.read<AddCategoryCubit>().clearImage();
        }
        if (state is UpdateCateogryFailure) {
          showCustomSnackBar(context, state.errMessage);
        }
      },
      builder: (context, state) {
        final cubit = context.read<AddCategoryCubit>();

        return Scaffold(
          backgroundColor: const Color(0xFFF8F9FA),
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(70),
            child: CustomAdminAppBar(
              title: 'Edit Category',
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
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: cubit.selectedImage != null
                            ? Image.file(
                                cubit.selectedImage!,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                              )
                            : Image.network(
                                widget.imageUrl,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                              ),
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
                    child: state is UpdateCateogryLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Color(kprimarycolor),
                            ),
                          )
                        : CustomButton(
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                cubit.updateCategory(
                                  name: nameController.text,
                                  docId: widget.docId,
                                  url: widget.imageUrl,
                                );
                              }
                            },
                            text: 'Update Category',
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
