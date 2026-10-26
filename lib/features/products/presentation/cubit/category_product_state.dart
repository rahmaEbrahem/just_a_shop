part of 'category_product_cubit.dart';

@immutable
sealed class CategoryProductState {}

final class CategoryProductInitial extends CategoryProductState {}

final class CategoryProductLoading extends CategoryProductState {}

final class CategoryProductSuccess extends CategoryProductState {
  final List<ProductModel> products;
  CategoryProductSuccess(this.products);
}

final class CategoryProductError extends CategoryProductState {
  final Failure failure;
  CategoryProductError(this.failure);
}
