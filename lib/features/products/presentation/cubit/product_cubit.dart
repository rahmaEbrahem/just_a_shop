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
  ProductSortOrder? currentSortOrder;

  Future<void> getProducts() async {
    emit(ProductLoading());

    try {
      final products = await ProductRepo.getProducts(
        limit: limit,
        skip: 0,
        sortOrder: currentSortOrder,
      );

      allProducts = products;
      skip = allProducts.length;
      hasMoreProducts = products.length == limit;

      emit(ProductSuccess(List.of(allProducts)));
    } catch (e) {
      final failure = ErrorHandler.handle(e);
      emit(ProductError(failure));
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
      final newProducts = await ProductRepo.getProducts(
        limit: limit,
        skip: skip,
        sortOrder: currentSortOrder,
      );

      allProducts.addAll(newProducts);
      skip = allProducts.length;
      hasMoreProducts = newProducts.length == limit;

      emit(ProductSuccess(List.of(allProducts)));
    } catch (e) {
      final failure = ErrorHandler.handle(e);
      emit(ProductError(failure));
    } finally {
      isLoadingMore = false;
    }
  }
}
