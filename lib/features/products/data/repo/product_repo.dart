import 'package:e_commerce_app/core/networking/api_endpoints.dart';
import 'package:e_commerce_app/core/networking/dio_factory.dart';
import 'package:e_commerce_app/features/products/data/model/product_model.dart';

class ProductRepo {
  static Future<List<ProductModel>> getProducts({
    required int limit,
    required int skip,
  }) async {
    final response = await DioFactory.dio.get(
      ApiEndpoints.allproductendpoints,
      queryParameters: {'limit': limit, 'skip': skip},
    );
    final List<dynamic> data = response.data["products"];
    return data.map((product) => ProductModel.fromJson(product)).toList();
  }

  static Future<List<ProductModel>> getProductsByCategory(
    String category,
  ) async {
    final response = await DioFactory.dio.get(
      '${ApiEndpoints.allproductendpoints}/category/$category',
    );

    final List<dynamic> data = response.data['products'];

    return data.map((product) => ProductModel.fromJson(product)).toList();
  }
}
