import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tawfeer_market/constants.dart';
import 'package:tawfeer_market/cubits/login_cubit/login_cubit.dart';
import 'package:tawfeer_market/cubits/login_cubit/login_states.dart';
import 'package:tawfeer_market/l10n/app_localizations.dart';
import 'package:tawfeer_market/pages/register_page.dart';
import 'package:tawfeer_market/pages/user_main_layout_page.dart';
import 'package:tawfeer_market/widgets/custom_button.dart';
import 'package:tawfeer_market/widgets/custom_snackbar.dart';
import 'package:tawfeer_market/widgets/custom_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static String id = 'login_page';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> formkey = GlobalKey();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isPasswordObscure = true;

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;

    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          Navigator.pushReplacementNamed(context, UserMainLayout.id);
        } else if (state is LoginFailure) {
          String message;
          switch (state.errorMessage) {
            case 'userNotFound':
              message = locale.userNotFound;
              break;
            case 'wrongPassword':
              message = locale.wrongPassword;
              break;
            case 'invalidCredentials':
              message = locale.invalidCredentials;
              break;
            default:
              message = locale.loginFailed;
          }
          showCustomSnackBar(context, message);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Form(
              key: formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 130),
                  Row(
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
                  const SizedBox(height: 100),
                  CustomTextField(
                    controller: emailController,
                    prefixIcon: Icons.email_outlined,
                    labelText: locale.loginEmailLabel,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return locale.loginEmailHint;
                      }
                      if (!value.contains('@')) {
                        return locale.loginEmailValid;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    controller: passwordController,
                    prefixIcon: Icons.lock_outline,
                    suffixIcon: isPasswordObscure
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    obscureText: isPasswordObscure,
                    onSuffixPressed: () {
                      setState(() {
                        isPasswordObscure = !isPasswordObscure;
                      });
                    },
                    labelText: locale.loginPasswordLabel,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return locale.loginPasswordHint;
                      }
                      if (value.length < 6) {
                        return locale.loginPasswordLength;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: state is LoginLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                            color: Color(kprimarycolor),
                          ))
                        : CustomButton(
                            onTap: () {
                              if (formkey.currentState!.validate()) {
                                BlocProvider.of<LoginCubit>(context).loginUser(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                            text: locale.signIn,
                            textColor: Colors.white,
                            filledColor: Color(kprimarycolor),
                          ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    locale.dontHaveAccount,
                    style: TextStyle(color: Colors.grey[800], fontSize: 16),
                  ),
                  const SizedBox(height: 15),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, RegisterPage.id);
                    },
                    child: Text(
                      locale.signUp,
                      style: TextStyle(
                        color: Color(kprimarycolor),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}