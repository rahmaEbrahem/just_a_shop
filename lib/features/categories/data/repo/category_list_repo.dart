import 'package:e_commerce_app/core/networking/api_endpoints.dart';
import 'package:e_commerce_app/core/networking/dio_factory.dart';

class CategoryListRepo {
  static Future<List<String>> getCategories() async {
    final response = await DioFactory.dio.get(ApiEndpoints.categoryendpoints);
    final List<dynamic> data = response.data;
    return data.cast<String>();
  }
}
