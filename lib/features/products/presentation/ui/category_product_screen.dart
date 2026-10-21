import 'package:e_commerce_app/features/products/presentation/cubit/category_product_cubit.dart';
import 'package:e_commerce_app/features/products/presentation/ui/widgets/category_product_bloc_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryProductsScreen extends StatelessWidget {
  final String category;

  const CategoryProductsScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CategoryProductCubit()..getProductsByCategory(category),
      child: Scaffold(
        appBar: AppBar(title: Text(category), centerTitle: true),
        body: const CategoryProductBlocBuilder(),
      ),
    );
  }
}
