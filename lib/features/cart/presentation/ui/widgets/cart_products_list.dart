import 'package:e_commerce_app/features/cart/presentation/ui/widgets/cart_items_list.dart';
import 'package:flutter/material.dart';

class CartProductsList extends StatelessWidget {
  final List items;

  const CartProductsList({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) {
        final item = items[index];
        return CartItemCard(item: item);
      },
    );
  }
}