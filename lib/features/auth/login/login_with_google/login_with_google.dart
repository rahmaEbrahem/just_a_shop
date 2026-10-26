import 'package:e_commerce_app/core/helper/extentions/extension.dart';
import 'package:e_commerce_app/core/routes/routes.dart';
import 'package:e_commerce_app/core/theme/app_colors.dart';
import 'package:e_commerce_app/features/auth/login/login_with_facebook/login_with_facebook.dart';
import 'package:e_commerce_app/gen/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<UserCredential?> signInWithGoogle(BuildContext context) async {
  try {
    await GoogleSignIn.instance.initialize(
      serverClientId:
          '135754886282-c29lin28f6hj7bv45ufkgc8vcmuuemm2.apps.googleusercontent.com',
    );

    final GoogleSignInAccount googleUser = await GoogleSignIn.instance
        .authenticate(scopeHint: ['email', 'profile']);

    final clientAuth = await googleUser.authorizationClient.authorizeScopes([
      'email',
      'profile',
    ]);

    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: clientAuth.accessToken,
      idToken: googleUser.authentication.idToken,
    );

    final UserCredential userCredential = await FirebaseAuth.instance
        .signInWithCredential(credential);

    final pendingCredential = pendingFacebookCredential;
    final pendingEmail = pendingFacebookEmail;
    bool facebookLinked = false;

    if (pendingCredential != null) {
      final googleEmail = userCredential.user?.email?.trim().toLowerCase();
      final facebookEmail = pendingEmail?.trim().toLowerCase();

      // Never link if we cannot verify that the emails match.
      if (googleEmail == null ||
          facebookEmail == null ||
          googleEmail != facebookEmail) {
        await FirebaseAuth.instance.signOut();

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(LocaleKeys.googleAccountMismatch.tr()),
              duration: const Duration(seconds: 5),
            ),
          );
        }

        return null;
      }

      try {
        await userCredential.user!.linkWithCredential(pendingCredential);

        pendingFacebookCredential = null;
        pendingFacebookEmail = null;
        facebookLinked = true;

        debugPrint('Facebook account linked successfully');
      } on FirebaseAuthException catch (e) {
        debugPrint('Facebook linking failed: ${e.code}');

        if (context.mounted) {
          final message = e.code == 'credential-already-in-use'
              ? LocaleKeys.facebookAccountAlreadyLinked.tr()
              : LocaleKeys.googleLoginSuccessFacebookLinkFailed.tr();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message),
              duration: const Duration(seconds: 5),
            ),
          );
        }

        // Keep the pending credential so linking can be retried.
      }
    }

    if (context.mounted) {
      if (facebookLinked) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(LocaleKeys.facebookGoogleLinked.tr())),
        );
      } else if (pendingCredential == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('login successfully').tr(),
            backgroundColor: AppColor.containercolor,
            duration: const Duration(seconds: 3),
          ),
        );
      }

      context.pushNamedAndRemoveUntil(Routes.navscreen, false);
    }

    return userCredential;
  } catch (e) {
    debugPrint('Google sign-in error: $e');

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(LocaleKeys.googleLoginFailed.tr()),
          backgroundColor: AppColor.containercolor,
          duration: const Duration(seconds: 3),
        ),
      );
    }

    return null;
  }
}
