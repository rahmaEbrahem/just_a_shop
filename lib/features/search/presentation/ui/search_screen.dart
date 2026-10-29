import 'package:e_commerce_app/features/search/data/repo/product_repo.dart';
import 'package:e_commerce_app/features/search/presentation/cubit/product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/features/search/widgets/header_search_screen.dart';
import 'package:e_commerce_app/features/search/widgets/recent_search.dart';
import 'package:e_commerce_app/features/search/widgets/search_card_proudect.dart';
import 'package:e_commerce_app/features/products/presentation/ui/product_details.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductCubit(ProductRepository()),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              const HeaderSearchScreen(),

              const SizedBox(height: 10),

              Expanded(
                child: BlocBuilder<ProductCubit, ProductState>(
                  builder: (context, state) {
                    if (state is ProductInitial) {
                      return const RecentSearch();
                    } else if (state is ProductLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is ProductSuccess) {
                      final products = state.products;

                      if (products.isEmpty) {
                        return const Center(
                          child: Text(
                            "No Results Found!",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                        );
                      }

                      return ListView.builder(
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          final product = products[index];
                          return SearchProductCard(
                            imageUrl: product.thumbnail,
                            title: product.title,
                            price: product.price.toString(),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductDetails(
                                    product: product,
                                  ), // استبدلي ProductModel بـ product
                                ),
                              );
                            },
                          );
                        },
                      );
                    } else if (state is ProductError) {
                      return Center(
                        child: Text(
                          "Error: ${state.message}",
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 16,
                          ),
                        ),
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
