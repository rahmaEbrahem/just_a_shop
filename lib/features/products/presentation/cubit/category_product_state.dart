part of 'category_product_cubit.dart';

@immutable
sealed class CategoryProductState {}

final class CategoryProductInitial extends CategoryProductState {}

final class CategoryProductLoading extends CategoryProductState {}

final class CategoryProductSuccess extends CategoryProductState {
  final List<ProductModel> products;
  final bool isFromCache;
  final bool hasConnectionError;

  CategoryProductSuccess(
    this.products, {
    this.isFromCache = false,
    this.hasConnectionError = false,
  });
}

final class CategoryProductError extends CategoryProductState {
  final Failure failure;
  CategoryProductError(this.failure);
}
