import 'package:e_commerce_app/core/routes/routes.dart';
import 'package:e_commerce_app/features/home/presentation/ui/home_screen.dart';
import 'package:e_commerce_app/features/auth/login/presentation/cubit/login_cubit.dart';
import 'package:e_commerce_app/features/auth/login/presentation/ui/login_screen.dart';
import 'package:e_commerce_app/features/auth/register/data/api_data/repo/register_repo.dart';
import 'package:e_commerce_app/features/auth/register/presentation/cubit/register_cubit.dart';
import 'package:e_commerce_app/features/auth/register/presentation/ui/register_screen.dart';
import 'package:e_commerce_app/features/onboarding/presentation/ui/onboarding.dart';
import 'package:e_commerce_app/features/onboarding/presentation/ui/theme_language_choose.dart';
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
        return MaterialPageRoute(builder: ((context) => HomeScreen()));
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
