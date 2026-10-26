import 'package:e_commerce_app/features/products/presentation/cubit/category_product_cubit.dart';
import 'package:e_commerce_app/features/products/presentation/ui/list_product.dart';
import 'package:e_commerce_app/gen/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryProductBlocBuilder extends StatelessWidget {
  final String category;
  const CategoryProductBlocBuilder({super.key, required this.category});

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
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    state.failure.failureMessage,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    onPressed: () {
                      context.read<CategoryProductCubit>().retryGetProducts(
                        category,
                      );
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text('Retry'),
                  ),
                ],
              ),
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
