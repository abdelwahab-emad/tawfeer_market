import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tawfeer_market/cubits/add_to_cart/add_to_cart_cubit.dart';
import 'package:tawfeer_market/l10n/app_localizations.dart';
import 'package:tawfeer_market/models/product_model.dart';
import 'package:tawfeer_market/widgets/custom_confirmation_sheet.dart';
import 'package:tawfeer_market/widgets/custom_snackbar.dart';

class AddToCartPage extends StatelessWidget {
  const AddToCartPage({super.key, required this.product});
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    final bool isOutOfStock = product.stock <= 0;

    return BlocConsumer<AddToCartCubit, AddToCartState>(
      listener: (context, state) {
        if (state is AddToCartSuccess) {
          showCustomSnackBar(
            context,
            locale.addToCartSuccess,
            color: Colors.green,
          );
          Navigator.pop(context);
        } else if (state is AddToCartFailure) {
          showCustomSnackBar(
            context,
            '${locale.addToCartFailure}: ${state.errorMessage}',
          );
        }
      },
      builder: (context, state) {
        return CustomConfirmationSheet(
          message: locale.addToCartConfirmation,
          leftButtonText: locale.notNow,
          rightButtonText: locale.confirm,
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
