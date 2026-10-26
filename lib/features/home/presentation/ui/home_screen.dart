import 'package:e_commerce_app/features/home/presentation/ui/widgets/category_row.dart';
import 'package:e_commerce_app/features/home/presentation/ui/widgets/home_header.dart';
import 'package:e_commerce_app/features/home/presentation/ui/widgets/home_search_bar.dart';
import 'package:e_commerce_app/features/home/presentation/ui/widgets/sorting_container.dart';
import 'package:e_commerce_app/features/products/presentation/cubit/product_cubit.dart';
import 'package:e_commerce_app/features/products/presentation/ui/widgets/product_bloc_builder.dart';
import 'package:e_commerce_app/gen/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        context.read<ProductCubit>().loadMoreProducts();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: ListView(
          controller: _scrollController,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                10.verticalSpace,
                HomeHeader(),
                20.verticalSpace,
                Row(
                  children: [
                    Expanded(child: HomeSearchBar()),
                    10.horizontalSpace,
                    SortingContainer(onSortingSelected: (sortOrder) {}),
                  ],
                ),
                20.verticalSpace,
                CategoryRow(),
                20.verticalSpace,
                Text(
                  LocaleKeys.allproduct.tr(),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                20.verticalSpace,
                ProductBlocBuilder(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
