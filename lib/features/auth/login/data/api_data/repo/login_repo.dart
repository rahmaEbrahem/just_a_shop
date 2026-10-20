import 'package:e_commerce_app/core/error_handl/error_handling.dart';
import 'package:e_commerce_app/core/networking/api_endpoints.dart';
import 'package:e_commerce_app/core/networking/dio_factory.dart';
import 'package:e_commerce_app/core/secure_storage/secure_storage.dart';
import 'package:e_commerce_app/core/secure_storage/user_storage.dart';
import 'package:e_commerce_app/features/auth/login/data/api_data/model/login_model.dart';
import 'package:e_commerce_app/features/auth/login/data/api_data/model/login_req_model.dart';
import 'package:flutter/foundation.dart';

class LoginRepo {
  static Future<dynamic> login(LoginReqModel loginreqmodel) async {
    try {
      final response = await DioFactory.dio.post(
        ApiEndpoints.loginendpoints,
        data: loginreqmodel.toJson(),
      );
      final data = response.data;
      final loginmodel = LoginModel.fromJson(data);
      await UserStorage.saveUser(
        id: loginmodel.id!,
        username: loginmodel.username!,
        email: loginmodel.email!,
        firstname: loginmodel.firstName!,
        lastname: loginmodel.lastName!,
      );
      if (loginmodel.accessToken != null) {
        await SecureStorage.saveAccessToken(loginmodel.accessToken);
      }
      if (loginmodel.refreshToken != null) {
        await SecureStorage.saveRefreshToken(loginmodel.refreshToken);
      }
      return loginmodel;
    } catch (e, stackTrace) {
      debugPrint('LOGIN ERROR:$e');
      debugPrint('STACK TRACE:$stackTrace');
      return ErrorHandler.handle(e);
    }
  }
}
