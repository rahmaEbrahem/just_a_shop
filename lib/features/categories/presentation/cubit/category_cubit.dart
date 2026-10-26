import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/core/error_handl/error_handling.dart';
import 'package:e_commerce_app/core/failure/failure.dart';
import 'package:e_commerce_app/features/categories/data/repo/category_list_repo.dart';
import 'package:meta/meta.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryInitial());
  Future<void> getcategories() async {
    emit(CategoryLoading());
    try {
      final categories = await CategoryListRepo.getCategories();
      emit(CategorySuccess(categories));
    } catch (e) {
      final failure = ErrorHandler.handle(e);
      emit(CategoryError(failure));
    }
  }
}
