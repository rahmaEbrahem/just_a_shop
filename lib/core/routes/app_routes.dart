import 'package:e_commerce_app/core/routes/routes.dart';
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
