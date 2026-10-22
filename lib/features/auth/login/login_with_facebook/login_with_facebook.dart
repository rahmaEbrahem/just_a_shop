import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:e_commerce_app/core/helper/extentions/extension.dart';
import 'package:e_commerce_app/core/routes/routes.dart';
import 'package:e_commerce_app/core/theme/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

String generateRawNonce([int length = 32]) {
  const charset =
      '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';

  final random = Random.secure();

  return List.generate(
    length,
    (_) => charset[random.nextInt(charset.length)],
  ).join();
}

String sha256OfString(String input) {
  return sha256.convert(utf8.encode(input)).toString();
}

Future<User?> signInWithFacebook(BuildContext context) async {
  try {
    await FacebookAuth.instance.logOut();

    final LoginResult result;
    String? rawNonce;

    if (Platform.isIOS) {
      rawNonce = generateRawNonce();
      final hashedNonce = sha256OfString(rawNonce);

      result = await FacebookAuth.instance.login(
        permissions: ['email', 'public_profile'],
        loginBehavior: LoginBehavior.dialogOnly,
        loginTracking: LoginTracking.limited,
        nonce: hashedNonce,
      );
    } else {
      result = await FacebookAuth.instance.login(
        permissions: ['email', 'public_profile'],
        loginBehavior: LoginBehavior.dialogOnly,
      );
    }

    if (result.status == LoginStatus.success) {
      final AccessToken accessToken = result.accessToken!;

      final AuthCredential credential;

      if (Platform.isIOS && accessToken.type == AccessTokenType.limited) {
        credential = OAuthProvider(
          'facebook.com',
        ).credential(idToken: accessToken.tokenString, rawNonce: rawNonce!);
      } else {
        credential = FacebookAuthProvider.credential(accessToken.tokenString);
      }

      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(credential);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('login successfully').tr(),
            backgroundColor: AppColor.containercolor,
            duration: const Duration(seconds: 3),
          ),
        );
        context.pushNamed(Routes.homescreen);
      }

      return userCredential.user;
    } else {
      print('فشل تسجيل الدخول: ${result.message}');

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'faild please try again: ${result.message ?? "تم إلغاء العملية"}',
            ).tr(),
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
