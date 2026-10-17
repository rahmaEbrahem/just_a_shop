import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/core/error_handl/error_handling.dart';
import 'package:e_commerce_app/core/failure/failure.dart';
import 'package:e_commerce_app/features/screens/auth/register/data/api_data/model/register_req_model.dart';
import 'package:e_commerce_app/features/screens/auth/register/data/api_data/repo/register_repo.dart';
import 'package:meta/meta.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterRepo registerRepo;
  RegisterCubit(this.registerRepo) : super(RegisterInitial());
  void registerState(RegisterReqModel body) async {
    emit(RegisterLoading());
    try {
      final response = await RegisterRepo.register(body);
      if (response != null) {
        emit(RegisterSuccess(data: response));
      } else if (response is Failure) {
        emit(RegisterError(message: response.failureMessage));
      }
    } catch (e) {
      final failure = ErrorHandler.handle(e);
      emit(RegisterError(message: failure.failureMessage));
    }
  }
}
