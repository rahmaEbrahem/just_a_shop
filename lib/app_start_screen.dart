import 'package:e_commerce_app/core/routes/routes.dart';
import 'package:e_commerce_app/core/secure_storage/secure_storage.dart';
import 'package:e_commerce_app/core/secure_storage/user_storage.dart';
import 'package:e_commerce_app/core/storage/settings_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppStartScreen extends StatefulWidget {
  const AppStartScreen({super.key});

  @override
  State<AppStartScreen> createState() => _AppStartScreenState();
}

class _AppStartScreenState extends State<AppStartScreen> {
  @override
  void initState() {
    super.initState();
    _checkUserSession();
  }

  Future<void> _checkUserSession() async {
    String initialRoute;

    // 1. Check Firebase session
    final firebaseUser = FirebaseAuth.instance.currentUser;

    // 2. Check DummyJSON API session
    final accessToken = await SecureStorage.getAccessToken();

    if (firebaseUser != null ||
        (accessToken != null && accessToken.isNotEmpty)) {
      initialRoute = Routes.navscreen;
    } else {
      // 3. Check onboarding status
      final onboardingCompleted = await UserStorage.isOnboardingCompleted();

      if (onboardingCompleted) {
        initialRoute = Routes.loginscreen;
      } else {
        // 4. Check saved language and theme settings
        final settings = SettingsStorage().getSettings();

        initialRoute = settings == null
            ? Routes.themelanguagechoose
            : Routes.onboarding;
      }
    }

    if (!mounted) return;

    Navigator.pushNamedAndRemoveUntil(context, initialRoute, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
