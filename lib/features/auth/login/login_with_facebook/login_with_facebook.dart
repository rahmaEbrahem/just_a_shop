import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:e_commerce_app/core/helper/extentions/extension.dart';
import 'package:e_commerce_app/core/routes/routes.dart';
import 'package:e_commerce_app/core/theme/app_colors.dart';
import 'package:e_commerce_app/gen/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

AuthCredential? pendingFacebookCredential;
String? pendingFacebookEmail;

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

    if (result.status != LoginStatus.success || result.accessToken == null) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(LocaleKeys.facebookLoginFailed.tr()),
            backgroundColor: AppColor.containercolor,
          ),
        );
      }
      return null;
    }

    final accessToken = result.accessToken!;

    final AuthCredential credential;

    if (Platform.isIOS && accessToken.type == AccessTokenType.limited) {
      credential = OAuthProvider(
        'facebook.com',
      ).credential(idToken: accessToken.tokenString, rawNonce: rawNonce!);
    } else {
      credential = FacebookAuthProvider.credential(accessToken.tokenString);
    }

    try {
      final userCredential = await FirebaseAuth.instance.signInWithCredential(
        credential,
      );

      pendingFacebookCredential = null;
      pendingFacebookEmail = null;

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('login successfully').tr(),
            backgroundColor: AppColor.containercolor,
            duration: const Duration(seconds: 3),
          ),
        );

        context.pushNamedAndRemoveUntil(Routes.navscreen, false);
      }

      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      debugPrint('Facebook sign-in error: ${e.code}');

      if (e.code == 'account-exists-with-different-credential' &&
          e.credential != null &&
          e.email != null) {
        pendingFacebookCredential = e.credential;
        pendingFacebookEmail = e.email;

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(LocaleKeys.accountAlreadyExistsMessage.tr()),
              duration: const Duration(seconds: 5),
            ),
          );
        }

        return null;
      }

      rethrow;
    }
  } catch (e) {
    debugPrint('Facebook sign-in error: $e');

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(LocaleKeys.facebookLoginFailed.tr()),
          backgroundColor: AppColor.containercolor,
          duration: const Duration(seconds: 3),
        ),
      );
    }

    return null;
  }
}
