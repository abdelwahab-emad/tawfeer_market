import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tawfeer_market/constants.dart';
import 'package:tawfeer_market/cubits/user/user_cubit.dart';
import 'package:tawfeer_market/l10n/app_localizations.dart';
import 'package:tawfeer_market/pages/edit_profile_page.dart';
import 'package:tawfeer_market/widgets/custom_button.dart';
import 'package:tawfeer_market/widgets/custom_snackbar.dart';
import 'package:tawfeer_market/widgets/custom_text_field.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  static String id = 'change_password_page';

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();

  bool isOldPasswordObscure = true;
  bool isNewPasswordObscure = true;

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          locale.changePassword,
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<UserCubit, UserState>(
        listener: (context, state) {
          if (state is UserUpdateSuccess) {
            showCustomSnackBar(
              context,
              locale.passwordChanged,
              color: Colors.green,
            );
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              Navigator.pushReplacementNamed(context, EditProfilePage.id);
            }
          } else if (state is UserFailure) {
            showCustomSnackBar(context, state.errorMessage);
          }
        },
        builder: (context, state) {
          return Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    locale.oldPassword,
                    style: const TextStyle(
                      fontSize: 26,
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                CustomTextField(
                  controller: oldPasswordController,
                  prefixIcon: Icons.lock_outline,
                  suffixIcon: isOldPasswordObscure
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  obscureText: isOldPasswordObscure,
                  onSuffixPressed: () {
                    setState(() {
                      isOldPasswordObscure = !isOldPasswordObscure;
                    });
                  },
                  labelText: locale.oldPassword,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return locale.oldPasswordEmpty;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    locale.newPassword,
                    style: const TextStyle(
                      fontSize: 26,
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                CustomTextField(
                  controller: newPasswordController,
                  prefixIcon: Icons.lock_outline,
                  suffixIcon: isNewPasswordObscure
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  obscureText: isNewPasswordObscure,
                  onSuffixPressed: () {
                    setState(() {
                      isNewPasswordObscure = !isNewPasswordObscure;
                    });
                  },
                  labelText: locale.newPassword,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return locale.newPasswordEmpty;
                    }
                    if (value.length < 6) {
                      return locale.passwordTooShort;
                    }
                    return null;
                  },
                ),
                const Spacer(flex: 1),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: state is UserLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Color(kprimarycolor),
                          ),
                        )
                      : CustomButton(
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              context.read<UserCubit>().changePassword(
                                    oldPassword: oldPasswordController.text,
                                    newPassword: newPasswordController.text,
                                  );
                            }
                          },
                          text: locale.updatePassword,
                          textColor: Colors.white,
                          filledColor: const Color(kprimarycolor),
                        ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }
}