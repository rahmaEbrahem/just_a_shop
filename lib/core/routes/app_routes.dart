import 'package:e_commerce_app/core/routes/routes.dart';
import 'package:e_commerce_app/features/screens/auth/register/presentation/ui/register_screen.dart';
import 'package:e_commerce_app/features/screens/onboarding/presentation/ui/onboarding.dart';
import 'package:e_commerce_app/features/screens/onboarding/presentation/ui/theme_language_choose.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static Route? onGenerateRoute(RouteSettings setting) {
    switch (setting.name) {
      case Routes.themelanguagechoose:
        return MaterialPageRoute(builder: (context) => ThemeLanguageChoose());
      case Routes.onboarding:
        return MaterialPageRoute(builder: (context) => Onboarding());
      case Routes.registerscreen:
        return MaterialPageRoute(builder: (context) => RegisterScreen());
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
