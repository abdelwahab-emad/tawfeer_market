import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tawfeer_market/cubits/cart/cart_cubit.dart';
import 'package:tawfeer_market/l10n/app_localizations.dart';
import 'package:tawfeer_market/models/product_model.dart';
import 'package:tawfeer_market/widgets/custom_confirmation_sheet.dart';
import 'package:tawfeer_market/widgets/custom_snackbar.dart';

class DeleteFromCartSheet extends StatelessWidget {
  const DeleteFromCartSheet({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;

    return CustomConfirmationSheet(
      message: locale.deleteFromCartConfirmation,
      messageColor: Colors.red,
      leftButtonText: locale.cancel,
      rightButtonText: locale.remove,
      onLeftTap: () => Navigator.pop(context),
      onRightTap: () {
        context.read<CartCubit>().deleteFromCart(productId: product.id);
        Navigator.pop(context);
        showCustomSnackBar(
          context,
          locale.deleteFromCartSuccess,
          color: Colors.red,
        );
      },
    );
  }
}