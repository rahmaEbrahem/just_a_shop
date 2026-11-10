import 'package:e_commerce_app/features/products/data/model/product_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ProductsCacheService {
  static const String _boxName = 'productsCacheBox';

  static Box get _box => Hive.box(_boxName);

  static Future<void> saveProducts({
    required String cacheKey,
    required List<ProductModel> products,
  }) async {
    final data = products.map((product) => product.toJson()).toList();

    await _box.put(cacheKey, data);
    print('SAVED CACHE KEY: $cacheKey');
    print('SAVED PRODUCTS COUNT: ${data.length}');
  }

  static List<ProductModel> getProducts(String cacheKey) {
    final cachedData = _box.get(cacheKey);
    print('Cache key: $cacheKey');
    print('Cached products: $cachedData');

    if (cachedData == null) return [];

    return (cachedData as List)
        .map(
          (item) =>
              ProductModel.fromJson(Map<String, dynamic>.from(item as Map)),
        )
        .toList();
  }

  static String getCategoryCacheKey(String category) {
    return 'category_products_$category';
  }
}
