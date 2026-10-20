import 'package:e_commerce_app/core/error_handl/error_handling.dart';
import 'package:e_commerce_app/core/networking/api_endpoints.dart';
import 'package:e_commerce_app/core/networking/dio_factory.dart';
import 'package:e_commerce_app/features/auth/register/data/api_data/model/register_req_model.dart';

class RegisterRepo {
  static Future<dynamic> register(RegisterReqModel registerreqmodel) async {
    try {
      final response = await DioFactory.dio.post(
        ApiEndpoints.registerendpoints,
        data: registerreqmodel.toJson(),
      );
      final data = response.data;
      return data;
    } catch (e) {
      return ErrorHandler.handle(e);
    }
  }
}
