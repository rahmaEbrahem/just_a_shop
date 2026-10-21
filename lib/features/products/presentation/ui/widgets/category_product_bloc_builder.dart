import 'package:e_commerce_app/features/products/presentation/cubit/category_product_cubit.dart';
import 'package:e_commerce_app/features/products/presentation/ui/list_product.dart';
import 'package:e_commerce_app/gen/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryProductBlocBuilder extends StatelessWidget {
  const CategoryProductBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryProductCubit, CategoryProductState>(
      builder: (context, state) {
        if (state is CategoryProductLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is CategoryProductSuccess) {
          if (state.products.isEmpty) {
            return Center(child: Text(LocaleKeys.noproduct.tr()));
          }

          return ListProducts(products: state.products, isScrollable: true);
        }

        if (state is CategoryProductError) {
          return Center(child: Text(state.failure.failureMessage));
        }

        return const SizedBox.shrink();
      },
    );
  }
}
