import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tawfeer_market/cubits/bottom_nav_cubit/bottom_nav_cubit.dart';
import 'package:tawfeer_market/cubits/login_cubit/login_cubit.dart';
import 'package:tawfeer_market/cubits/register_cubit/register_cubit.dart';
import 'package:tawfeer_market/firebase_options.dart';
import 'package:tawfeer_market/pages/cart_page.dart';
import 'package:tawfeer_market/pages/home_page.dart';
import 'package:tawfeer_market/pages/login_page.dart';
import 'package:tawfeer_market/pages/profile_page.dart';
import 'package:tawfeer_market/pages/register_page.dart';
import 'package:tawfeer_market/pages/splash_page.dart';
import 'package:tawfeer_market/pages/user_main_layout.dart';
import 'package:tawfeer_market/pages/wishlist_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const TawfeerMarket());
}

class TawfeerMarket extends StatelessWidget {
  const TawfeerMarket({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        SplashPage.id : (context) => const SplashPage(),
        LoginPage.id : (context) => BlocProvider(
          create: (context) => LoginCubit(),
          child: const LoginPage(),
        ),
        RegisterPage.id : (context) => BlocProvider(
          create: (context) => RegisterCubit(),
          child: const RegisterPage(),
        ),
        HomePage.id : (context) => const HomePage(),
        CartPage.id : (context) => const CartPage(),
        WishlistPage.id : (context) => const WishlistPage(),
        ProfilePage.id : (context) => const ProfilePage(),
        UserMainLayout.id : (context) => BlocProvider(
          create: (context) => BottomNavCubit(),
          child: const UserMainLayout(),
        )
      },
      initialRoute: SplashPage.id,
    );
  }
}