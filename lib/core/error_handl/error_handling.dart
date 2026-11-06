import 'package:dio/dio.dart';
import 'package:e_commerce_app/core/failure/failure.dart';
import 'package:e_commerce_app/gen/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class ErrorHandler {
  static Failure handle(dynamic exception) {
    if (exception is DioException) {
      final statusCode = exception.response?.statusCode;
      if (statusCode == 400) {
        return Failure(
          failureMessage: LocaleKeys.invalidcredentials.tr(),
          statusCode: statusCode,
        );
      }
      if (statusCode == 401) {
        return Failure(
          failureMessage: LocaleKeys.unauth.tr(),
          statusCode: statusCode,
        );
      }
      if (statusCode == 403) {
        return Failure(
          failureMessage: LocaleKeys.forbidden.tr(),
          statusCode: statusCode,
        );
      }
      if (statusCode == 404) {
        return Failure(
          failureMessage: LocaleKeys.notfound.tr(),
          statusCode: statusCode,
        );
      }
      if (statusCode == 422) {
        return Failure(
          failureMessage: LocaleKeys.unprocessable.tr(),
          statusCode: statusCode,
        );
      }
      if (statusCode != null && statusCode >= 500) {
        return Failure(
          failureMessage: LocaleKeys.servererror.tr(),
          statusCode: statusCode,
        );
      }
      final errorMassege = exception.message ?? '';
      if (errorMassege.contains('SocketException') ||
          errorMassege.contains('Connection failed') ||
          errorMassege.contains('HandshakeException')) {
        return Failure(failureMessage: LocaleKeys.socket.tr());
      }
      if (errorMassege.contains('Timeout')) {
        return Failure(failureMessage: LocaleKeys.deadline.tr());
      }
      return Failure(
        failureMessage: LocaleKeys.exception.tr(),
        statusCode: statusCode,
      );
    }

    return Failure(failureMessage: LocaleKeys.unexpected.tr());
  }
}
