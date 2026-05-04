import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tawfeer_market/cubits/category_cubit/category_cubit.dart';
import 'package:tawfeer_market/cubits/product_cubit/product_cubit.dart';
import 'package:tawfeer_market/widgets/custom_confirmation_sheet.dart';
import 'package:tawfeer_market/widgets/custom_snackbar.dart';

class DeleteProductSheet extends StatelessWidget {
  const DeleteProductSheet({super.key, required this.docId});
  final String docId;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductCubit, ProductState>(
      listener: (context, state) {
        if (state is ProductDeleteSuccess) {
          Navigator.pop(context);
          showCustomSnackBar(
            context,
            'Deleted Successfully',
            color: Colors.green,
          );
        } else if (state is ProductDeleteError) {
          showCustomSnackBar(context, state.message);
        }
      },
      builder: (context, state) {
        return CustomConfirmationSheet(
          message: 'Are you sure you want to delete this product?',
          messageColor: Colors.red,
          leftButtonText: 'Cancel',
          rightButtonText: 'Delete',

          onLeftTap: () => Navigator.pop(context),

          onRightTap: () {
            context.read<ProductCubit>().deleteProduct(docId);
            Navigator.pop(context);
          },
        );
      },
    );
  }
}
