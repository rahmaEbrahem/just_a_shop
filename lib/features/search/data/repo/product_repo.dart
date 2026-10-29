import 'package:dio/dio.dart';
import 'package:e_commerce_app/core/networking/dio_factory.dart';
import 'package:e_commerce_app/features/search/data/model/product_model.dart';

class ProductRepository {
  Future<ProductResponse> searchProducts(String query) async {
    try {
      final response = await DioFactory.dio.get(
        '/products/search',
        queryParameters: {'q': query},
      );

      return ProductResponse.fromJson(response.data as Map<String, dynamic>);
    } on DioException {
      rethrow;
    }
  }
}
