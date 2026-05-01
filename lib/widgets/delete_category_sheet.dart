import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tawfeer_market/cubits/category_cubit/category_cubit.dart';
import 'package:tawfeer_market/widgets/custom_confirmation_sheet.dart';
import 'package:tawfeer_market/widgets/custom_snackbar.dart';

class DeleteCategorySheet extends StatelessWidget {
  const DeleteCategorySheet({super.key, required this.docId});
  final String docId;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoryCubit, CategoryState>(
      listener: (context, state) {
        if (state is CategoryDeleteSuccess) {
          Navigator.pop(context);
          showCustomSnackBar(
            context,
            'Deleted Successfully',
            color: Colors.green,
          );
        } else if (state is CategoryDeleteError) {
          showCustomSnackBar(context, state.message);
        }
      },
      builder: (context, state) {
        return CustomConfirmationSheet(
          message: 'Are you sure you want to delete this category?',
          messageColor: Colors.red,
          leftButtonText: 'Cancel',
          rightButtonText: 'Delete',

          onLeftTap: () => Navigator.pop(context),

          onRightTap: () {
            context.read<CategoryCubit>().deleteCategory(docId);
            Navigator.pop(context);
          },
        );
      },
    );
  }
}
