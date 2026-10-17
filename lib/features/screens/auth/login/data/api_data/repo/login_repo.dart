import 'package:e_commerce_app/core/error_handl/error_handling.dart';
import 'package:e_commerce_app/core/networking/api_endpoints.dart';
import 'package:e_commerce_app/core/networking/dio_factory.dart';
import 'package:e_commerce_app/core/secure_storage/secure_storage.dart';
import 'package:e_commerce_app/features/screens/auth/login/data/api_data/model/login_model.dart';
import 'package:flutter/foundation.dart';

class LoginRepo {
  static Future<dynamic> login(String email, String password) async {
    try {
      final response = await DioFactory.dio.post(
        ApiEndpoints.loginendpoints,
        data: {"email": email, "password": password},
      );
      final data = response.data["data"];
      final loginmodel = LoginModel.fromjson(data);
      if (loginmodel.accessToken != null) {
        await SecureStorage.saveAccessToken(loginmodel.accessToken);
      }
      if (loginmodel.refreshToken != null) {
        await SecureStorage.saveRefreshToken(loginmodel.refreshToken);
      }
      return loginmodel;
    } catch (e) {
      return ErrorHandler.handle(e);
    }
  }
}
