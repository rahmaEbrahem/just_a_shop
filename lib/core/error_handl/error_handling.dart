import 'package:dio/dio.dart';
import 'package:e_commerce_app/core/failure/failure.dart';
import 'package:e_commerce_app/gen/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class ErrorHandler {
  static Failure handle(dynamic exception) {
    if (exception is DioException) {
      return _handleRemoteError(exception.toString());
    }

    return Failure(failureMessage: LocaleKeys.unexpected.tr());
  }

  static Failure _handleRemoteError(String message) {
    final errorMessage = message.trim();

    if (errorMessage.contains('401') ||
        errorMessage.contains('Unauthorized') ||
        errorMessage.contains('Unauthenticated')) {
      return Failure(failureMessage: LocaleKeys.unauth.tr());
    }

    if (errorMessage.contains('403') || errorMessage.contains('Forbidden')) {
      return Failure(failureMessage: LocaleKeys.forbidden.tr());
    }

    if (errorMessage.contains('404') || errorMessage.contains('Not Found')) {
      return Failure(failureMessage: LocaleKeys.notfound.tr());
    }

    if (errorMessage.contains('422') ||
        errorMessage.contains('Unprocessable Content')) {
      return Failure(failureMessage: LocaleKeys.unprocessable.tr());
    }

    if (errorMessage.contains('500') ||
        errorMessage.contains('Internal Server Error')) {
      return Failure(failureMessage: LocaleKeys.servererror.tr());
    }

    if (errorMessage.contains('SocketException') ||
        errorMessage.contains('Connection failed') ||
        errorMessage.contains('HandshakeException')) {
      return Failure(failureMessage: LocaleKeys.socket.tr());
    }

    if (errorMessage.contains('Timeout') || errorMessage.contains('Deadline')) {
      return Failure(failureMessage: LocaleKeys.deadline.tr());
    }

    if (errorMessage.contains('TypeError') ||
        errorMessage.contains('FormatException')) {
      return Failure(failureMessage: LocaleKeys.formatexception.tr());
    }

    if (errorMessage.isNotEmpty &&
        !errorMessage.contains('Exception') &&
        !errorMessage.contains('Error')) {
      return Failure(failureMessage: LocaleKeys.exception.tr());
    }

    return Failure(failureMessage: LocaleKeys.exception.tr());
  }
}
