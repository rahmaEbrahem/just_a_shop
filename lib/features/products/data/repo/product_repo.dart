import 'package:e_commerce_app/core/networking/api_endpoints.dart';
import 'package:e_commerce_app/core/networking/dio_factory.dart';
import 'package:e_commerce_app/core/services/products_cach_service.dart';
import 'package:e_commerce_app/features/home/presentation/ui/widgets/product_sort_order.dart';
import 'package:e_commerce_app/features/products/data/model/product_model.dart';

class CachedProductsResult {
  final List<ProductModel> products;
  final bool isFromCache;

  CachedProductsResult({required this.products, required this.isFromCache});
}

class ProductRepo {
  static String getProductsCacheKey(ProductSortOrder? sortOrder) {
    return 'products_first_page_${sortOrder?.name ?? 'default'}';
  }

  static Future<CachedProductsResult> getProducts({
    required int limit,
    required int skip,
    ProductSortOrder? sortOrder,
  }) async {
    final cacheKey = getProductsCacheKey(sortOrder);

    try {
      final queryParameters = <String, dynamic>{'limit': limit, 'skip': skip};

      if (sortOrder != null) {
        queryParameters['sortBy'] = 'price';
        queryParameters['order'] = sortOrder == ProductSortOrder.priceLowToHigh
            ? 'asc'
            : 'desc';
      }

      final response = await DioFactory.dio.get(
        ApiEndpoints.allproductendpoints,
        queryParameters: queryParameters,
      );

      final List<dynamic> data = response.data['products'];

      final products = data
          .map((product) => ProductModel.fromJson(product))
          .toList();

      if (skip == 0) {
        await ProductsCacheService.saveProducts(
          cacheKey: cacheKey,
          products: products,
        );
      }

      return CachedProductsResult(products: products, isFromCache: false);
    } catch (e, stackTrace) {
      print('PRODUCT API ERROR: $e');
      print('CACHE KEY: $cacheKey');
      print('SKIP: $skip');

      if (skip == 0) {
        try {
          print('START READING CACHE');

          final cachedProducts = ProductsCacheService.getProducts(cacheKey);

          print('CACHE COUNT: ${cachedProducts.length}');

          if (cachedProducts.isNotEmpty) {
            print('RETURNING PRODUCTS FROM CACHE');

            return CachedProductsResult(
              products: cachedProducts,
              isFromCache: true,
            );
          }

          print('CACHE IS EMPTY');
        } catch (cacheError, cacheStackTrace) {
          print('CACHE READ ERROR: $cacheError');
          print('CACHE STACK TRACE: $cacheStackTrace');
        }
      }

      print('RETHROWING PRODUCT ERROR');
      print('STACK TRACE: $stackTrace');

      rethrow;
    }
  }

  static Future<CachedProductsResult> getProductsByCategory(
    String category,
  ) async {
    final cacheKey = ProductsCacheService.getCategoryCacheKey(category);

    try {
      final response = await DioFactory.dio.get(
        '${ApiEndpoints.allproductendpoints}/category/$category',
      );

      final List<dynamic> data = response.data['products'];

      final products = data
          .map((product) => ProductModel.fromJson(product))
          .toList();

      await ProductsCacheService.saveProducts(
        cacheKey: cacheKey,
        products: products,
      );

      return CachedProductsResult(products: products, isFromCache: false);
    } catch (e) {
      print('CATEGORY API ERROR: $e');
      print('CATEGORY CACHE KEY: $cacheKey');

      final cachedProducts = ProductsCacheService.getProducts(cacheKey);

      print('CATEGORY CACHE COUNT: ${cachedProducts.length}');

      if (cachedProducts.isNotEmpty) {
        return CachedProductsResult(
          products: cachedProducts,
          isFromCache: true,
        );
      }

      rethrow;
    }
  }
}
