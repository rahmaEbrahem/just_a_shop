import 'package:e_commerce_app/features/products/presentation/cubit/product_cubit.dart';
import 'package:e_commerce_app/features/products/presentation/ui/list_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductBlocBuilder extends StatelessWidget {
  const ProductBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        if (state is ProductLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is ProductSuccess) {
          return ListProducts(products: state.products);
        }
        if (state is ProductLoadingMore) {
          return ListProducts(products: state.products, isLoadingMore: true);
        }

        if (state is ProductError) {
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
                      context.read<ProductCubit>().retryGetProducts();
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
