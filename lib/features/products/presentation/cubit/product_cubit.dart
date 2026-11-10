import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/core/error_handl/error_handling.dart';
import 'package:e_commerce_app/core/failure/failure.dart';
import 'package:e_commerce_app/features/home/presentation/ui/widgets/product_sort_order.dart';
import 'package:e_commerce_app/features/products/data/model/product_model.dart';
import 'package:e_commerce_app/features/products/data/repo/product_repo.dart';
import 'package:meta/meta.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());

  final int limit = 10;
  int skip = 0;
  bool isLoadingMore = false;
  bool hasMoreProducts = true;
  List<ProductModel> allProducts = [];
  bool isShowingCachedProducts = false;
  ProductSortOrder? currentSortOrder;

  Future<void> getProducts() async {
    // Show full loading only when there are no products to display.
    if (allProducts.isEmpty) {
      emit(ProductLoading());
    }

    try {
      final result = await ProductRepo.getProducts(
        limit: limit,
        skip: 0,
        sortOrder: currentSortOrder,
      );

      print('CUBIT PRODUCTS COUNT: ${result.products.length}');
      print('IS FROM CACHE: ${result.isFromCache}');

      allProducts = result.products;
      isShowingCachedProducts = result.isFromCache;
      skip = allProducts.length;

      hasMoreProducts = !result.isFromCache && result.products.length == limit;

      emit(
        ProductSuccess(
          List.of(allProducts),
          isFromCache: isShowingCachedProducts,
          hasConnectionError: result.isFromCache,
        ),
      );
    } catch (e) {
      print('GET PRODUCTS ERROR: $e');

      if (allProducts.isNotEmpty) {
        // Keep the already displayed products.
        emit(
          ProductSuccess(
            List.of(allProducts),
            isFromCache: isShowingCachedProducts,
            hasConnectionError: true,
          ),
        );
      } else {
        final failure = ErrorHandler.handle(e);
        emit(ProductError(failure));
      }
    }
  }

  Future<void> retryGetProducts() async {
    skip = 0;
    hasMoreProducts = true;
    await getProducts();
  }

  Future<void> changeSortOrder(ProductSortOrder sortOrder) async {
    if (currentSortOrder == sortOrder) return;

    currentSortOrder = sortOrder;
    skip = 0;
    hasMoreProducts = true;
    isLoadingMore = false;
    allProducts = [];

    await getProducts();
  }

  Future<void> loadMoreProducts() async {
    if (isLoadingMore || !hasMoreProducts) return;

    isLoadingMore = true;
    emit(ProductLoadingMore(List.of(allProducts)));

    try {
      final result = await ProductRepo.getProducts(
        limit: limit,
        skip: skip,
        sortOrder: currentSortOrder,
      );

      allProducts.addAll(result.products);
      skip = allProducts.length;
      hasMoreProducts = result.products.length == limit;

      emit(ProductSuccess(List.of(allProducts)));
    } catch (e) {
      print('LOAD MORE ERROR: $e');

      emit(
        ProductSuccess(
          List.of(allProducts),
          isFromCache: false,
          hasConnectionError: true,
        ),
      );
    } finally {
      isLoadingMore = false;
    }
  }
}
