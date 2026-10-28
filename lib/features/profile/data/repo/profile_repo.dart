import 'package:dio/dio.dart';
import 'package:e_commerce_app/core/networking/api_endpoints.dart';
import 'package:e_commerce_app/core/networking/dio_factory.dart';
import 'package:e_commerce_app/core/secure_storage/secure_storage.dart';
import 'package:e_commerce_app/features/profile/data/model/profile_model.dart';

class ProfileRepo {
  Future<UserProfileModel> getUserProfile() async {
    final token = await SecureStorage.getAccessToken();

    if (token == null || token.isEmpty) {
      throw Exception('Access token not found');
    }

    final response = await DioFactory.dio.get(
      ApiEndpoints.getuserdata,
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );

    return UserProfileModel.fromJson(response.data as Map<String, dynamic>);
  }

  Future<Map<String, dynamic>> updateUserProfile({
    required int userId,
    required String country,
    required String city,
    required String address,
  }) async {
    final token = await SecureStorage.getAccessToken();

    if (token == null || token.isEmpty) {
      throw Exception('Access token not found');
    }

    final response = await DioFactory.dio.put(
      '${ApiEndpoints.updateuserdata}$userId',
      data: {
        'address': {'country': country, 'city': city, 'address': address},
      },
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );

    return Map<String, dynamic>.from(response.data);
  }
}
