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
          return Center(child: Text(state.failure.failureMessage));
        }

        return const SizedBox.shrink();
      },
    );
  }
}
