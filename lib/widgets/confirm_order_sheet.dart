import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tawfeer_market/cubits/cart/cart_cubit.dart';
import 'package:tawfeer_market/cubits/dashboard/dashboard_cubit.dart';
import 'package:tawfeer_market/models/product_model.dart';
import 'package:tawfeer_market/widgets/custom_confirmation_sheet.dart';
import 'package:tawfeer_market/widgets/custom_snackbar.dart';

class ConfirmOrderSheet extends StatelessWidget {
  const ConfirmOrderSheet({super.key, required this.products});
  
  final List<ProductModel> products;
  @override
  Widget build(BuildContext context) {
    return  CustomConfirmationSheet(
      message: 'Are you sure you want to confirm this order?',
      leftButtonText: 'Cancel',
      rightButtonText: 'Confirm',
      onLeftTap: () => Navigator.pop(context),
      onRightTap: () {
        context.read<CartCubit>().confirmOrder(products: products);
        context.read<DashboardCubit>().incrementOrdersCount();
        Navigator.pop(context);
        showCustomSnackBar(
          context,
          'Order placed successfully!',
          color: Colors.green,
        );
      },
    );
  }
}