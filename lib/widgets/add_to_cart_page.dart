import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tawfeer_market/cubits/cubit/add_to_cart_cubit.dart';
import 'package:tawfeer_market/models/product_model.dart';
import 'package:tawfeer_market/widgets/custom_confirmation_sheet.dart';
import 'package:tawfeer_market/widgets/custom_snackbar.dart';

class AddToCartPage extends StatelessWidget {
  const AddToCartPage({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddToCartCubit, AddToCartState>(
      listener: (context, state) {
        if (state is AddToCartSuccess) {
          showCustomSnackBar(
            context,
            'Product added to cart successfully!',
            color: Colors.green,
          );
          Navigator.pop(context);
        } else if (state is AddToCartFailure) {
          showCustomSnackBar(
            context,
            'Failed to add product to cart: ${state.errorMessage}',
          );
        }
      },
      builder: (context, state) {
        return CustomConfirmationSheet(
          message: 'Are you sure you want to add this item to your cart?',
          leftButtonText: 'Not Now',
          rightButtonText: 'Confirm',
          onLeftTap: () => Navigator.pop(context),
          onRightTap: () {
            context.read<AddToCartCubit>().addProductToCart(product: product);
          },
          isLoading: state is AddToCartLoading,
        );
      },
    );
  }
}