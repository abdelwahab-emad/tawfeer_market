import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tawfeer_market/constants.dart';
import 'package:tawfeer_market/cubits/register_cubit/register_cubit.dart';
import 'package:tawfeer_market/cubits/register_cubit/register_states.dart';
import 'package:tawfeer_market/pages/home_page.dart';
import 'package:tawfeer_market/pages/login_page.dart';
import 'package:tawfeer_market/widgets/custom_button.dart';
import 'package:tawfeer_market/widgets/custom_snackbar.dart';
import 'package:tawfeer_market/widgets/custom_text_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  static String id = 'Register_page';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> formKey = GlobalKey();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  bool isPasswordObscure = true;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          Navigator.pushReplacementNamed(context, HomePage.id);
        } else if (state is RegisterFailure) {
          showCustomSnackBar(context, state.errorMessage);
        }
      },

      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  const SizedBox(height: 100),
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
                  const SizedBox(height: 50),

                  CustomTextField(
                    controller: firstNameController,
                    prefixIcon: Icons.person_outline,
                    labelText: 'First Name',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your first name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),

                  CustomTextField(
                    controller: lastNameController,
                    prefixIcon: Icons.person_outline,
                    labelText: 'Last Name',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your last name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),

                  CustomTextField(
                    controller: emailController,
                    prefixIcon: Icons.email_outlined,
                    labelText: 'Email Address',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!value.contains('@')) {
                        return 'Please enter a valid email';
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
                    labelText: 'Password',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: state is RegisterLoading
                        ? const Center(child: CircularProgressIndicator())
                        : CustomButton(
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                BlocProvider.of<RegisterCubit>(
                                  context,
                                ).registerUser(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                            text: 'Sign Up',
                            textColor: Colors.white,
                            filledColor: Color(kprimarycolor),
                          ),
                  ),
                  const SizedBox(height: 15),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an Account? ",
                        style: TextStyle(color: Colors.grey[800], fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, LoginPage.id);
                        },
                        child: Text(
                          "Sign in",
                          style: TextStyle(
                            color: Color(kprimarycolor),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
