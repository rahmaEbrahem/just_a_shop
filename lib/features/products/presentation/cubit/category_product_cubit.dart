import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/core/error_handl/error_handling.dart';
import 'package:e_commerce_app/core/failure/failure.dart';
import 'package:e_commerce_app/features/products/data/model/product_model.dart';
import 'package:e_commerce_app/features/products/data/repo/product_repo.dart';
import 'package:meta/meta.dart';

part 'category_product_state.dart';

class CategoryProductCubit extends Cubit<CategoryProductState> {
  CategoryProductCubit() : super(CategoryProductInitial());

  List<ProductModel> allProducts = [];
  String? currentCategory;
  bool isShowingCachedProducts = false;

  Future<void> getProductsByCategory(String category) async {
    if (currentCategory != category) {
      allProducts = [];
      isShowingCachedProducts = false;
    }
    currentCategory = category;

    // Don't hide existing products during retry.
    if (allProducts.isEmpty) {
      emit(CategoryProductLoading());
    }

    try {
      final result = await ProductRepo.getProductsByCategory(category);

      print('CATEGORY PRODUCTS COUNT: ${result.products.length}');
      print('CATEGORY IS FROM CACHE: ${result.isFromCache}');

      allProducts = result.products;
      isShowingCachedProducts = result.isFromCache;

      emit(
        CategoryProductSuccess(
          List.of(allProducts),
          isFromCache: isShowingCachedProducts,
          hasConnectionError: result.isFromCache,
        ),
      );
    } catch (e) {
      print('CATEGORY PRODUCTS ERROR: $e');

      if (allProducts.isNotEmpty) {
        emit(
          CategoryProductSuccess(
            List.of(allProducts),
            isFromCache: isShowingCachedProducts,
            hasConnectionError: true,
          ),
        );
      } else {
        final failure = ErrorHandler.handle(e);
        emit(CategoryProductError(failure));
      }
    }
  }

  Future<void> retryGetProducts(String category) async {
    await getProductsByCategory(category);
  }
}
