part of 'register_cubit.dart';

@immutable
sealed class RegisterState {}

final class RegisterInitial extends RegisterState {}

final class RegisterLoading extends RegisterState {}

final class RegisterSuccess extends RegisterState {
  final dynamic data;
  RegisterSuccess({required this.data});
}

final class RegisterError extends RegisterState {
  final String message;
  RegisterError({required this.message});
}
