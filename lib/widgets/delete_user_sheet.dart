import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tawfeer_market/cubits/users_cubit/users_cubit.dart';
import 'package:tawfeer_market/widgets/custom_confirmation_sheet.dart';
import 'package:tawfeer_market/widgets/custom_snackbar.dart';

class DeleteUserSheet extends StatelessWidget {
  const DeleteUserSheet({
    super.key,
    required this.userId,
    required this.userName,
  });

  final String userId;
  final String userName;

  @override
  Widget build(BuildContext context) {
    return CustomConfirmationSheet(
      message:
          'Are you sure you want to delete $userName?',
      leftButtonText: 'Cancel',
      rightButtonText: 'Delete',
      messageColor: Colors.red,
      onLeftTap: () => Navigator.pop(context),
      onRightTap: () async {
        await context.read<UsersCubit>().deleteUser(userId);

        Navigator.pop(context);

        showCustomSnackBar(
          context,
          'User deleted successfully.',
          color: Colors.green,
        );
      },
    );
  }
}