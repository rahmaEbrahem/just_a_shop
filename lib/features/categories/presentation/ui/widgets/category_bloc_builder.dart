import 'package:e_commerce_app/features/categories/presentation/cubit/category_cubit.dart';
import 'package:e_commerce_app/features/categories/presentation/ui/widgets/list_categories.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryBlocBuilder extends StatelessWidget {
  const CategoryBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        if (state is CategoryLoading) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is CategorySuccess) {
          return ListCategories(categories: state.categories);
        }
        if (state is CategoryError) {
          return Center(child: Text(state.failure.failureMessage));
        }
        return SizedBox.shrink();
      },
    );
  }
}
