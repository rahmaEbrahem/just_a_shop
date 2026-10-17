import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/core/error_handl/error_handling.dart';
import 'package:e_commerce_app/core/failure/failure.dart';
import 'package:e_commerce_app/features/screens/auth/login/data/api_data/repo/login_repo.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  Future<void> login(String email, String password) async {
    emit(LoginLoading());
    try {
      final response = await LoginRepo.login(email, password);
      if (response is Failure) {
        emit(LoginError(message: response.failureMessage));
      } else {
        emit(LoginSuccess());
      }
    } catch (e) {
      final failure = ErrorHandler.handle(e);
      emit(LoginError(message: failure.failureMessage));
    }
  }
}
