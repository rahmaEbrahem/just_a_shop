import 'package:e_commerce_app/core/error_handl/error_handling.dart';
import 'package:e_commerce_app/core/networking/api_endpoints.dart';
import 'package:e_commerce_app/core/networking/dio_factory.dart';
import 'package:e_commerce_app/core/secure_storage/secure_storage.dart';
import 'package:e_commerce_app/features/auth/login/data/api_data/model/login_model.dart';
import 'package:flutter/foundation.dart';

class RefreshRepo {
  static Future<dynamic> refreshToken() async {
    try {
      // Get saved refresh token
      final refreshToken = await SecureStorage.getRefreshToken();

      if (refreshToken == null || refreshToken.isEmpty) {
        return null;
      }

      // Send refresh request
      final response = await DioFactory.dio.post(
        ApiEndpoints.refreshTokenEndpoint,
        data: {"refreshToken": refreshToken, "expiresInMins": 30},
      );

      // Parse response
      final loginModel = LoginModel.fromJson(response.data);

      // Save new tokens
      if (loginModel.accessToken != null) {
        await SecureStorage.saveAccessToken(loginModel.accessToken);
      }

      if (loginModel.refreshToken != null) {
        await SecureStorage.saveRefreshToken(loginModel.refreshToken);
      }

      return loginModel;
    } catch (e, stackTrace) {
      debugPrint('REFRESH TOKEN ERROR: $e');
      debugPrint('STACK TRACE: $stackTrace');

      return ErrorHandler.handle(e);
    }
  }
}
