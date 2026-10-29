import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/features/search/data/model/product_model.dart';
import 'package:e_commerce_app/features/search/data/repo/product_repo.dart';
import 'package:meta/meta.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductRepository productRepository;

  ProductCubit(this.productRepository) : super(ProductInitial());

  void searchProducts(String query) async {
    if (query.trim().isEmpty) {
      emit(ProductInitial());
      return;
    }

    emit(ProductLoading());

    try {
      ProductResponse response = await productRepository.searchProducts(query);
      emit(ProductSuccess(response.products));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }
}
