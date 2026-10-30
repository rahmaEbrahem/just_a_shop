import 'package:e_commerce_app/features/products/presentation/ui/product_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/core/app_widgets/app_bottom_nav_bar.dart';
import 'package:e_commerce_app/core/routes/routes.dart';
import 'package:e_commerce_app/features/auth/login/presentation/cubit/login_cubit.dart';
import 'package:e_commerce_app/features/auth/login/presentation/ui/login_screen.dart';
import 'package:e_commerce_app/features/auth/register/data/api_data/repo/register_repo.dart';
import 'package:e_commerce_app/features/auth/register/presentation/cubit/register_cubit.dart';
import 'package:e_commerce_app/features/auth/register/presentation/ui/register_screen.dart';
import 'package:e_commerce_app/features/cart/presentation/ui/cart_screen.dart';
import 'package:e_commerce_app/features/categories/presentation/cubit/category_cubit.dart';
import 'package:e_commerce_app/features/categories/presentation/ui/categories_sceens.dart';
import 'package:e_commerce_app/features/home/presentation/ui/home_screen.dart';
import 'package:e_commerce_app/features/onboarding/presentation/ui/onboarding.dart';
import 'package:e_commerce_app/features/onboarding/presentation/ui/theme_language_choose.dart';
import 'package:e_commerce_app/features/products/data/model/product_model.dart';
import 'package:e_commerce_app/features/profile/presentation/ui/profile_screen.dart';
import 'package:e_commerce_app/features/search/presentation/ui/search_screen.dart';

class AppRoutes {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.themelanguagechoose:
        return MaterialPageRoute(
          builder: (context) => const ThemeLanguageChoose(),
        );

      case Routes.onboarding:
        return MaterialPageRoute(
          builder: (context) => const Onboarding(),
        );

      case Routes.registerscreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => RegisterCubit(RegisterRepo()),
            child: const RegisterScreen(),
          ),
        );

      case Routes.loginscreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => LoginCubit(),
            child: const LoginScreen(),
          ),
        );

      case Routes.homescreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => CategoryCubit()..getcategories(),
            child: const HomeScreen(),
          ),
        );

      case Routes.categoriesscreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => CategoryCubit()..getcategories(),
            child: const CategoriesSceens(),
          ),
        );

      case Routes.searchscreen:
        return MaterialPageRoute(
          builder: (context) => const SearchScreen(),
        );

      case Routes.cartscreen:
        return MaterialPageRoute(
          builder: (context) => const CartScreen(),
        );

      case Routes.profilescreen:
        return MaterialPageRoute(
          builder: (context) => const ProfileScreen(),
        );

      case Routes.navscreen:
        return MaterialPageRoute(
          builder: (context) => const AppBottomNavBar(),
        );

      case Routes.productdetailsscreen:
        final product = settings.arguments;
        if (product is ProductModel) {
          return MaterialPageRoute(
            builder: (context) => ProductDetails(product: product),
          );
        }
        return _undefinedRoute();

      default:
        return _undefinedRoute();
    }
  }

  static Route _undefinedRoute() {
    return MaterialPageRoute(
      builder: (context) => const Scaffold(
        body: Center(
          child: Text("404 - Page Not Found"),
        ),
      ),
    );
  }
}