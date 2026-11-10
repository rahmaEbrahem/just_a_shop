part of 'product_cubit.dart';

@immutable
sealed class ProductState {}

final class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoadingMore extends ProductState {
  final List<ProductModel> products;
  final bool isFromCache;
  ProductLoadingMore(this.products, {this.isFromCache = false});
}

class ProductSuccess extends ProductState {
  final List<ProductModel> products;
  final bool isFromCache;
  final bool hasConnectionError;

  ProductSuccess(
    this.products, {
    this.isFromCache = false,
    this.hasConnectionError = false,
  });
}

class ProductError extends ProductState {
  final Failure failure;

  ProductError(this.failure);
}
