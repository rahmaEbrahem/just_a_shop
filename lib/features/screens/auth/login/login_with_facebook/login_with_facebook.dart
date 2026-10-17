import 'package:e_commerce_app/core/theme/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

Future<User?> signInWithFacebook(BuildContext context) async {
  try {
    await FacebookAuth.instance.logOut();

    final LoginResult result = await FacebookAuth.instance.login(
      permissions: ['email', 'public_profile'],
      loginBehavior: LoginBehavior.dialogOnly,
    );

    if (result.status == LoginStatus.success) {
      final AccessToken accessToken = result.accessToken!;

      final AuthCredential credential = FacebookAuthProvider.credential(accessToken.tokenString);

      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('login successfully').tr(),
            backgroundColor: AppColor.containercolor,
            duration: const Duration(seconds: 3),
          ),
        );
      }

      return userCredential.user;
    } else {
      print('فشل تسجيل الدخول: ${result.message}');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('faild please try again: ${result.message ?? "تم إلغاء العملية"}').tr(),
            backgroundColor: AppColor.containercolor,
            duration: const Duration(seconds: 3),
          ),
        );
      }
      return null;
    }
  } catch (e) {
    print('خطأ أثناء تسجيل الدخول: $e');
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('faild please try again: $e'),
          backgroundColor: AppColor.containercolor,
          duration: const Duration(seconds: 3),
        ),
      );
    }
    return null;
  }
}