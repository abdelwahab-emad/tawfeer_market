import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tawfeer_market/cubits/add_category/add_category_cubit.dart';
import 'package:tawfeer_market/cubits/add_product/add_product_cubit.dart';
import 'package:tawfeer_market/cubits/bottom_nav_cubit/bottom_nav_cubit.dart';
import 'package:tawfeer_market/cubits/cart/cart_cubit.dart';
import 'package:tawfeer_market/cubits/category_cubit/category_cubit.dart';
import 'package:tawfeer_market/cubits/add_to_cart/add_to_cart_cubit.dart';
import 'package:tawfeer_market/cubits/favorite/favorite_cubit.dart';
import 'package:tawfeer_market/cubits/language/language_cubit.dart';
import 'package:tawfeer_market/cubits/login_cubit/login_cubit.dart';
import 'package:tawfeer_market/cubits/orders/orders_cubit.dart';
import 'package:tawfeer_market/cubits/product_cubit/product_cubit.dart';
import 'package:tawfeer_market/cubits/register_cubit/register_cubit.dart';
import 'package:tawfeer_market/cubits/user/user_cubit.dart';
import 'package:tawfeer_market/firebase_options.dart';
import 'package:tawfeer_market/l10n/app_localizations.dart';
import 'package:tawfeer_market/pages/admin_hub_page.dart';
import 'package:tawfeer_market/pages/cart_page.dart';
import 'package:tawfeer_market/pages/change_password_page.dart';
import 'package:tawfeer_market/pages/dashboard_page.dart';
import 'package:tawfeer_market/pages/home_page.dart';
import 'package:tawfeer_market/pages/login_page.dart';
import 'package:tawfeer_market/pages/manage_categories_page.dart';
import 'package:tawfeer_market/pages/more_page.dart';
import 'package:tawfeer_market/pages/orders_page.dart';
import 'package:tawfeer_market/pages/products_page.dart';
import 'package:tawfeer_market/pages/register_page.dart';
import 'package:tawfeer_market/pages/splash_page.dart';
import 'package:tawfeer_market/pages/user_main_layout_page.dart';
import 'package:tawfeer_market/pages/Favorites_page.dart';
import 'package:tawfeer_market/pages/users_managment_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const TawfeerMarket());
}

class TawfeerMarket extends StatelessWidget {
  const TawfeerMarket({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => RegisterCubit()),
        BlocProvider(create: (context) => BottomNavCubit()),
        BlocProvider(create: (context) => CategoryCubit()..getCategories()),
        BlocProvider(create: (context) => ProductCubit()),
        BlocProvider(create: (context) => AddToCartCubit()),
        BlocProvider(create: (context) => CartCubit()),
        BlocProvider(
          create: (context) => FavoriteCubit()..getFavoriteProducts(),
        ),
        BlocProvider(create: (context) => LanguageCubit()..getSavedLanguage()),
        BlocProvider(create: (context) => OrdersCubit()),
        BlocProvider(create: (context) => UserCubit()),
        BlocProvider(create : (context) => AddCategoryCubit()),
        BlocProvider(create: (context) => AddProductCubit()),
        BlocProvider(create:  (context) => UserCubit()),
      ],
      child: BlocBuilder<LanguageCubit, LanguageState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            locale: state.locale,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],

            supportedLocales: const [
              Locale('en'), 
              Locale('ar'), 
            ],
            routes: {
              SplashPage.id: (context) => const SplashPage(),
              LoginPage.id: (context) => const LoginPage(),
              RegisterPage.id: (context) => const RegisterPage(),
              HomePage.id: (context) => const HomePage(),
              CartPage.id: (context) => const CartPage(),
              FavoritesPage.id: (context) => const FavoritesPage(),
              MorePage.id: (context) => const MorePage(),
              UserMainLayout.id: (context) => const UserMainLayout(),
              OrdersPage.id: (context) => const OrdersPage(),
              ChangePasswordPage.id: (context) => const ChangePasswordPage(),
              AdminHubPage.id : (context) => const AdminHubPage(),
              DashboardPage.id : (context) => const DashboardPage(),
              ProductsPage.id : (context) => const ProductsPage(),
              ManageCategoriesPage.id : (context) => const ManageCategoriesPage(),
              UsersManagmentPage.id : (context) => const UsersManagmentPage(),
            },
            initialRoute: SplashPage.id,
          );
        },
      ),
    );
  }
}
