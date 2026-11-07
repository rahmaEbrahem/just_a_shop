import 'package:e_commerce_app/core/secure_storage/secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserStorage {
  static Future<void> saveUser({
    required int id,
    required String username,
    required String email,
    required String firstname,
    required String lastname,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt("id", id);
    await prefs.setString("username", username);
    await prefs.setString("email", email);
    await prefs.setString("firstName", firstname);
    await prefs.setString("lastName", lastname);
  }

  static Future<int?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt("id");
  }

  static Future<String?> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("username");
  }

  static Future<String?> getFirstName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("firstName");
  }

  static Future<String?> getLastName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("lastName");
  }

  static Future<String?> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("email");
  }

  static Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("id");
    await prefs.remove("username");
    await prefs.remove("firstName");
    await prefs.remove("lastName");
    await prefs.remove("email");
  }

  static Future<void> saveOnboardingCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboardingCompleted', true);
  }

  static Future<bool> isOnboardingCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('onboardingCompleted') ?? false;
  }

  static Future<void> logout() async {
    await SecureStorage.deleteTokens();
    await clearUser();
  }
}
