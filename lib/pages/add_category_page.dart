import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tawfeer_market/constants.dart';
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
  final ImagePicker picker = ImagePicker();

  bool hasImage = false;
  bool isLoading = false;
  File? imageFile;

  Future<void> pickImage() async {
    final picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      setState(() {
        imageFile = File(picked.path);
        hasImage = true;
      });
    }
  }

  void submit() async {
    if (!formKey.currentState!.validate()) return;

    if (!hasImage) {
      showCustomSnackBar(
        context,
        'Please upload category image',
        color: Colors.red,
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      await Future.delayed(const Duration(seconds: 1));

      setState(() {
        isLoading = false;
        imageFile = null;
        hasImage = false;
        nameController.clear();
      });

      showCustomSnackBar(
        context,
        'Category added successfully',
        color: Colors.green,
      );
    } catch (e) {
      setState(() {
        isLoading = false;
      });

      showCustomSnackBar(context, 'Something went wrong', color: Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
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
                onTap: pickImage,
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
                            imageFile!,
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
                child: CustomButton(
                  onTap: submit,
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
  }
}
