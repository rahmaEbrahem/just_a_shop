import 'package:e_commerce_app/features/cart/presentation/ui/cart_screen.dart';
import 'package:e_commerce_app/features/categories/presentation/cubit/category_cubit.dart';
import 'package:e_commerce_app/features/categories/presentation/ui/categories_sceens.dart';
import 'package:e_commerce_app/features/home/presentation/ui/home_screen.dart';
import 'package:e_commerce_app/features/products/presentation/cubit/product_cubit.dart';
import 'package:e_commerce_app/features/profile/presentation/ui/profile_screen.dart';
import 'package:e_commerce_app/features/search/presentation/ui/search_screen.dart';
import 'package:e_commerce_app/gen/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBottomNavBar extends StatefulWidget {
  static void navigateToCategories(BuildContext context) {
    final state = context.findAncestorStateOfType<_AppBottomNavBarState>();
    state?.changeTab(1);
  }

  static void navigateToSearch(BuildContext context) {
    final state = context.findAncestorStateOfType<_AppBottomNavBarState>();
    state?.changeTab(2);
  }

  const AppBottomNavBar({super.key});

  @override
  State<AppBottomNavBar> createState() => _AppBottomNavBarState();
}

class _AppBottomNavBarState extends State<AppBottomNavBar> {
  void changeTab(int index) {
    setState(() {
      activeindex = index;
    });
  }

  int activeindex = 0;
  List<Widget> screens = [
    HomeScreen(),
    CategoriesSceens(),
    SearchScreen(),
    CartScreen(),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CategoryCubit()..getcategories()),
        BlocProvider(create: (context) => ProductCubit()..getProducts()),
      ],

      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: activeindex,
          onTap: (index) {
            changeTab(index);
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: LocaleKeys.home.tr(),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.grid_view_outlined),
              activeIcon: Icon(Icons.grid_view_rounded),
              label: LocaleKeys.categories.tr(),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search_outlined),
              activeIcon: Icon(Icons.search),
              label: LocaleKeys.search.tr(),
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_outlined),
              activeIcon: Icon(Icons.shopping_cart),
              label: LocaleKeys.cart.tr(),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: LocaleKeys.account.tr(),
            ),
          ],
        ),
        body: screens[activeindex],
      ),
    );
  }
}
