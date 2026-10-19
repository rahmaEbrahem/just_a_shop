import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static final storage = FlutterSecureStorage();

  static Future<void> saveAccessToken(String? token) async {
    await storage.write(key: "accessToken", value: token);
  }

  static Future<void> saveRefreshToken(String? token) async {
    await storage.write(key: "refreshToken", value: token);
  }

  static Future<String?> getAccessToken() async {
    return await storage.read(key: "accessToken");
  }

  static Future<String?> getRefreshToken() async {
    return await storage.read(key: "refreshToken");
  }

  static Future<void> deleteTokens() async {
    await storage.deleteAll();
  }
}
