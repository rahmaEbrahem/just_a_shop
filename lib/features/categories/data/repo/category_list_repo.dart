import 'package:e_commerce_app/core/networking/api_endpoints.dart';
import 'package:e_commerce_app/core/networking/dio_factory.dart';
import 'package:e_commerce_app/core/services/categories_cache_service.dart';

class CategoryListRepo {
  static Future<List<String>> getCategories() async {
    try {
      final response = await DioFactory.dio.get(ApiEndpoints.categoryendpoints);

      final List<dynamic> data = response.data;
      final categories = data.cast<String>();

      await CategoriesCacheService.saveCategories(categories);

      return categories;
    } catch (e) {
      final cachedCategories = CategoriesCacheService.getCategories();

      if (cachedCategories.isNotEmpty) {
        return cachedCategories;
      }

      rethrow;
    }
  }
}
