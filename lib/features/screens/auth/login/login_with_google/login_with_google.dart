import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart';

Future<UserCredential?> signInWithGoogle() async {
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

    return await FirebaseAuth.instance.signInWithCredential(credential);
  } catch (e) {
    debugPrint("خطأ أثناء تسجيل الدخول: $e");
    return null;
  }
}