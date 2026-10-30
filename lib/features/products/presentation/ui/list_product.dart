import 'package:e_commerce_app/features/products/data/model/product_model.dart';
import 'package:e_commerce_app/features/products/presentation/ui/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ListProducts extends StatelessWidget {
  final List<ProductModel> products;
  final bool isLoadingMore;
  final bool isScrollable;

  const ListProducts({
    super.key,
    required this.products,
    this.isLoadingMore = false,
    this.isScrollable = false,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: !isScrollable,
      physics: isScrollable
          ? const AlwaysScrollableScrollPhysics()
          : const NeverScrollableScrollPhysics(),
      itemCount: products.length + (isLoadingMore ? 1 : 0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.65,
      ),
      itemBuilder: (context, index) {
        if (index >= products.length) {
          return Center(child: CircularProgressIndicator());
        }
        return ProductCard(product: products[index]);
      },
    );
  }
}
