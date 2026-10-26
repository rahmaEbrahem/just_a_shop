import 'package:e_commerce_app/core/app_widgets/app_bottom_nav_bar.dart';
import 'package:e_commerce_app/core/routes/routes.dart';
import 'package:e_commerce_app/features/cart/presentation/ui/cart_screen.dart';
import 'package:e_commerce_app/features/categories/presentation/cubit/category_cubit.dart';
import 'package:e_commerce_app/features/categories/presentation/ui/categories_sceens.dart';
import 'package:e_commerce_app/features/home/presentation/ui/home_screen.dart';
import 'package:e_commerce_app/features/auth/login/presentation/cubit/login_cubit.dart';
import 'package:e_commerce_app/features/auth/login/presentation/ui/login_screen.dart';
import 'package:e_commerce_app/features/auth/register/data/api_data/repo/register_repo.dart';
import 'package:e_commerce_app/features/auth/register/presentation/cubit/register_cubit.dart';
import 'package:e_commerce_app/features/auth/register/presentation/ui/register_screen.dart';
import 'package:e_commerce_app/features/onboarding/presentation/ui/onboarding.dart';
import 'package:e_commerce_app/features/onboarding/presentation/ui/theme_language_choose.dart';
import 'package:e_commerce_app/features/products/data/model/product_model.dart';
import 'package:e_commerce_app/features/products/presentation/ui/product_details.dart';
import 'package:e_commerce_app/features/profile/presentation/ui/profile_screen.dart';
import 'package:e_commerce_app/features/search/presentation/ui/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRoutes {
  static Route? onGenerateRoute(RouteSettings setting) {
    switch (setting.name) {
      case Routes.themelanguagechoose:
        return MaterialPageRoute(builder: (context) => ThemeLanguageChoose());
      case Routes.onboarding:
        return MaterialPageRoute(builder: (context) => Onboarding());
      case Routes.registerscreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => RegisterCubit(RegisterRepo()),
            child: RegisterScreen(),
          ),
        );
      case Routes.loginscreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => LoginCubit(),
            child: LoginScreen(),
          ),
        );
      case Routes.homescreen:
        return MaterialPageRoute(
          builder: ((context) => BlocProvider(
            create: (context) => CategoryCubit()..getcategories(),
            child: HomeScreen(),
          )),
        );
      case Routes.categoriesscreen:
        return MaterialPageRoute(
          builder: ((context) => BlocProvider(
            create: (context) => CategoryCubit()..getcategories(),
            child: CategoriesSceens(),
          )),
        );
      case Routes.searchscreen:
        return MaterialPageRoute(builder: ((context) => SearchScreen()));
      case Routes.cartscreen:
        return MaterialPageRoute(builder: ((context) => CartScreen()));
      case Routes.profilescreen:
        return MaterialPageRoute(builder: ((context) => ProfileScreen()));
      case Routes.navscreen:
        return MaterialPageRoute(builder: ((context) => AppBottomNavBar()));
      case Routes.productdetailsscreen:
        final product = setting.arguments as ProductModel;
        return MaterialPageRoute(
          builder: ((context) => ProductDetails(product: product)),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text("404 not found")],
              ),
            ),
          ),
        );
    }
  }
}
