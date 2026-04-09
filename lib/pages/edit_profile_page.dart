import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tawfeer_market/constants.dart';
import 'package:tawfeer_market/cubits/bottom_nav_cubit/bottom_nav_cubit.dart';
import 'package:tawfeer_market/cubits/user/user_cubit.dart';
import 'package:tawfeer_market/l10n/app_localizations.dart';
import 'package:tawfeer_market/widgets/custom_button.dart';
import 'package:tawfeer_market/widgets/custom_snackbar.dart';
import 'package:tawfeer_market/widgets/custom_text_field.dart';
import 'package:tawfeer_market/widgets/delete_account_sheet.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  static const String id = 'edit_profile_page';

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<UserCubit>().getUserData();
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

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
          locale.editProfile,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<UserCubit, UserState>(
        listener: (context, state) {
          if (state is UserSuccess) {
            firstNameController.text = state.userData['firstName'] ?? '';
            lastNameController.text = state.userData['lastName'] ?? '';
            passwordController.text =
                '*' * (state.userData['password']?.length ?? 8);
          }
          if (state is UserUpdateSuccess) {
            showCustomSnackBar(
              context,
              locale.profileUpdated,
              color: Colors.green,
            );
            context.read<BottomNavCubit>().changeIndex(0);
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 30),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Tawfeer ',
                        style: TextStyle(
                          fontSize: 36,
                          color: Color(kprimarycolor),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        'Market',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                CustomTextField(
                  controller: firstNameController,
                  labelText: locale.firstName,
                  prefixIcon: Icons.person_outline,
                ),
                CustomTextField(
                  controller: lastNameController,
                  labelText: locale.lastName,
                  prefixIcon: Icons.person_outline,
                ),
                Stack(
                  alignment: AlignmentDirectional.centerEnd,
                  children: [
                    CustomTextField(
                      controller: passwordController,
                      labelText: locale.loginPasswordLabel,
                      readOnly: true,
                      prefixIcon: Icons.lock_outline,
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(end: 35),
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, 'change_password_page');
                        },
                        child: Text(
                          locale.change,
                          style: const TextStyle(
                            color: Color(kprimarycolor),
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: state is UserLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Color(kprimarycolor),
                          ),
                        )
                      : CustomButton(
                          onTap: () {
                            context.read<UserCubit>().updateUserData(
                                  firstName: firstNameController.text,
                                  lastName: lastNameController.text,
                                );
                          },
                          text: locale.editProfile,
                          textColor: Colors.white,
                          filledColor: const Color(kprimarycolor),
                        ),
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: CustomButton(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.transparent,
                        builder: (context) => const DeleteAccountSheet(),
                        isScrollControlled: true,
                      );
                    },
                    text: locale.deleteAccount,
                    textColor: Colors.red,
                    filledColor: Colors.white,
                    borderColor: Colors.red,
                    borderWidth: 1,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}