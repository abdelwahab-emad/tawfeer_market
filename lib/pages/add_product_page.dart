import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tawfeer_market/constants.dart';
import 'package:tawfeer_market/widgets/custom_admin_app_bar.dart';
import 'package:tawfeer_market/widgets/custom_button.dart';
import 'package:tawfeer_market/widgets/custom_drop_down_field.dart';
import 'package:tawfeer_market/widgets/custom_text_field.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  String? selectedCategory;
  String? selectedType;

  final List<String> categories = [
    'Fruits',
    'Vegetables',
    'Dairy',
    'Snacks',
    'Drinks',
  ];

  final List<String> types = ['Daily Needs', 'Top Selling', 'other'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: CustomAdminAppBar(
          title: 'Add New Product',
          actionIcon: IconButton(
            icon: const Icon(Icons.filter_list_rounded, color: Colors.black),
            onPressed: () {},
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.grey.withOpacity(0.3)),
                  ),
                  child: const Column(
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
              labelText: 'Product Name',
              prefixIcon: Icons.shopping_bag_outlined,
            ),
            const SizedBox(height: 15),

            CustomDropdownField(
              labelText: 'Category',
              items: categories,
              prefixIcon: Icons.category_outlined,
              value: selectedCategory,
              onChanged: (value) {
                setState(() {
                  selectedCategory = value;
                });
              },
            ),
            const SizedBox(height: 15),

            CustomDropdownField(
              labelText: 'Product Type',
              items: types,
              prefixIcon: Icons.label_important_outline_rounded,
              value: selectedType,
              onChanged: (value) {
                setState(() {
                  selectedType = value;
                });
              },
            ),
            const SizedBox(height: 15),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      labelText: 'Price',
                      prefixIcon: Icons.attach_money_rounded,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'^\d+\.?\d{0,2}'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: CustomTextField(
                      labelText: 'Discount %',
                      prefixIcon: Icons.percent_rounded,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'^\d+\.?\d{0,2}'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 15),
            CustomTextField(
              labelText: 'Initial Stock (Quantity)',
              prefixIcon: Icons.inventory_2_outlined,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),

            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: CustomButton(
                onTap: () {},
                text: 'Add Product',
                textColor: Colors.white,
                filledColor: Color(kprimarycolor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
