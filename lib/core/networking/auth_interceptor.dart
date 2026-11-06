import 'package:dio/dio.dart';
import 'package:e_commerce_app/core/failure/failure.dart';
import 'package:e_commerce_app/core/networking/api_endpoints.dart';
import 'package:e_commerce_app/core/networking/dio_factory.dart';
import 'package:e_commerce_app/core/routes/app_navigator.dart';
import 'package:e_commerce_app/core/routes/routes.dart';
import 'package:e_commerce_app/core/secure_storage/secure_storage.dart';
import 'package:e_commerce_app/core/secure_storage/user_storage.dart';
import 'package:e_commerce_app/features/auth/login/data/api_data/model/login_model.dart';
import 'package:e_commerce_app/features/auth/login/data/api_data/repo/refresh_token_repo.dart';

class AuthInterceptor extends Interceptor {
  Future<dynamic>? _refreshFuture;
  bool _isLoggingOut = false;

  Future<void> _logoutApiUser() async {
    if (_isLoggingOut) return;

    _isLoggingOut = true;

    await UserStorage.logout();

    AppNavigator.navigatorKey.currentState?.pushNamedAndRemoveUntil(
      Routes.loginscreen,
      (route) => false,
    );
  }

  Future<dynamic> _refreshTokenOnce() {
    return _refreshFuture ??= RefreshRepo.refreshToken().whenComplete(() {
      _refreshFuture = null;
    });
  }

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (options.path == ApiEndpoints.loginendpoints ||
        options.path == ApiEndpoints.refreshTokenEndpoint) {
      return handler.next(options);
    }

    final token = await SecureStorage.getAccessToken();

    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final requestOptions = err.requestOptions;

    // Ignore errors that should not trigger refresh
    if (err.response?.statusCode != 401 ||
        requestOptions.path == ApiEndpoints.loginendpoints ||
        requestOptions.path == ApiEndpoints.refreshTokenEndpoint ||
        requestOptions.extra['retried'] == true) {
      return handler.next(err);
    }

    try {
      // All requests share the same refresh operation
      final result = await _refreshTokenOnce();

      // Refresh succeeded
      if (result is LoginModel &&
          result.accessToken != null &&
          result.accessToken!.isNotEmpty) {
        requestOptions.extra['retried'] = true;

        requestOptions.headers['Authorization'] =
            'Bearer ${result.accessToken}';

        // Retry the original request
        final response = await DioFactory.dio.fetch(requestOptions);

        return handler.resolve(response);
      }

      // No refresh token is available
      if (result == null) {
        await _logoutApiUser();
        return handler.next(err);
      }

      // Refresh token was rejected
      if (result is Failure &&
          (result.statusCode == 401 || result.statusCode == 403)) {
        await _logoutApiUser();
        return handler.next(err);
      }

      // Network or server error: keep the API session
      return handler.next(err);
    } catch (e) {
      return handler.next(err);
    }
  }
}
