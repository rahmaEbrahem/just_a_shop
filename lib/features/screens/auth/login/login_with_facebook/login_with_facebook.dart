import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

Future<User?> signInWithFacebook() async {
  try {
    final LoginResult result = await FacebookAuth.instance.login(
      permissions: ['email', 'public_profile'],
    );

    if (result.status == LoginStatus.success) {
      final AccessToken accessToken = result.accessToken!;

      
      final OAuthCredential credential = FacebookAuthProvider.credential(accessToken.tokenString);
      
      final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      
      return userCredential.user;
    } else {
      print('فشل تسجيل الدخول: ${result.message}');
      return null;
    }
  } catch (e) {
    print('خطأ أثناء تسجيل الدخول: $e');
    return null;
  }
}