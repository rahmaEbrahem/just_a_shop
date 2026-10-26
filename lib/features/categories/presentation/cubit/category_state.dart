part of 'category_cubit.dart';

@immutable
sealed class CategoryState {}

final class CategoryInitial extends CategoryState {}

final class CategoryLoading extends CategoryState {}

final class CategorySuccess extends CategoryState {
  final List<String> categories;
  CategorySuccess(this.categories);
}

final class CategoryError extends CategoryState {
  final Failure failure;
  CategoryError(this.failure);
}
