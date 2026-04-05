import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tawfeer_market/constants.dart';
import 'package:tawfeer_market/cubits/add_to_cart/add_to_cart_cubit.dart';
import 'package:tawfeer_market/cubits/bottom_nav_cubit/bottom_nav_cubit.dart';
import 'package:tawfeer_market/models/product_model.dart';
import 'package:tawfeer_market/pages/user_main_layout_page.dart';
import 'package:tawfeer_market/widgets/custom_button.dart';
import 'package:tawfeer_market/widgets/custom_snackbar.dart';

class AddToCartPage extends StatelessWidget {
  const AddToCartPage({super.key, required this.product});

  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      height: 180,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Are you sure you want to add this item to your cart?',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 30),
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  onTap: () => Navigator.pop(context),
                  text: 'Not Now',
                  textColor: Color(kprimarycolor),
                  filledColor: Colors.white,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: BlocConsumer<AddToCartCubit, AddToCartState>(
                  listener: (context, state) {
                    if (state is AddToCartSuccess) {
                      showCustomSnackBar(
                        context,
                        'Product added to cart successfully!',
                        color: Colors.green,
                      );
                      context.read<BottomNavCubit>().changeIndex(1);
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => const UserMainLayout(),
                        ),
                        (route) => false,
                      );
                    } else if (state is AddToCartFailure) {
                      showCustomSnackBar(
                        context,
                        'Failed to add product to cart: ${state.errorMessage}',
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is AddToCartLoading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Color(kprimarycolor),
                        ),
                      );
                    }
                    return CustomButton(
                      onTap: () => context
                          .read<AddToCartCubit>()
                          .addProductToCart(product: product),
                      text: 'Confirm',
                      textColor: Colors.white,
                      filledColor: Color(kprimarycolor),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
