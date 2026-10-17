import 'package:e_commerce_app/core/theme/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<UserCredential?> signInWithGoogle(BuildContext context) async {
  try {
    await GoogleSignIn.instance.initialize(
      serverClientId: '135754886282-c29lin28f6hj7bv45ufkgc8vcmuuemm2.apps.googleusercontent.com',
    );

    final GoogleSignInAccount googleUser = await GoogleSignIn.instance.authenticate(
      scopeHint: ['email', 'profile'],
    );

    final clientAuth = await googleUser.authorizationClient.authorizeScopes(['email', 'profile']);
    
    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: clientAuth?.accessToken,
      idToken: googleUser.authentication.idToken,
    );

    final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('login successfully').tr(),
          backgroundColor: AppColor.containercolor,
          duration: const Duration(seconds: 3),
        ),
      );
    }

    return userCredential;
  } catch (e) {
    debugPrint("خطأ أثناء تسجيل الدخول: $e");

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('faild please try again: $e').tr(),
          backgroundColor: AppColor.containercolor,
          duration: const Duration(seconds: 3),
        ),
      );
    }
    return null;
  }
}