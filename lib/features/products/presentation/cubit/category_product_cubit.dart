import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/core/error_handl/error_handling.dart';
import 'package:e_commerce_app/core/failure/failure.dart';
import 'package:e_commerce_app/features/products/data/model/product_model.dart';
import 'package:e_commerce_app/features/products/data/repo/product_repo.dart';
import 'package:meta/meta.dart';

part 'category_product_state.dart';

class CategoryProductCubit extends Cubit<CategoryProductState> {
  CategoryProductCubit() : super(CategoryProductInitial());
  Future<void> getProductsByCategory(String category) async {
    emit(CategoryProductLoading());

    try {
      final products = await ProductRepo.getProductsByCategory(category);
      emit(CategoryProductSuccess(products));
    } catch (e) {
      final failure = ErrorHandler.handle(e);
      emit(CategoryProductError(failure));
    }
  }

  Future<void> retryGetProducts(String category) async {
    await getProductsByCategory(category);
  }
}
