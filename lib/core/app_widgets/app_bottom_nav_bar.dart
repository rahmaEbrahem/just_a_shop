import 'package:e_commerce_app/core/routes/routes.dart';
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
    _goToTab(context, 1);
  }

  static void navigateToSearch(BuildContext context) {
    _goToTab(context, 2);
  }

  static void navigateToCart(BuildContext context) {
    _goToTab(context, 3);
  }

  static void _goToTab(BuildContext context, int index) {
  
    Navigator.of(context).popUntil(
      (route) => route.settings.name == Routes.navscreen || route.isFirst,
    );
    _AppBottomNavBarState._current?.changeTab(index);
  }

  const AppBottomNavBar({super.key});

  @override
  State<AppBottomNavBar> createState() => _AppBottomNavBarState();
}

class _AppBottomNavBarState extends State<AppBottomNavBar> {
  static _AppBottomNavBarState? _current;

  int activeindex = 0;

  final List<Widget> screens = [
    HomeScreen(),
    CategoriesSceens(),
    SearchScreen(),
    const CartScreen(),
    const ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _current = this;
  }

  @override
  void dispose() {
    if (_current == this) _current = null;
    super.dispose();
  }

  void changeTab(int index) {
    setState(() {
      activeindex = index;
    });
  }

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
          type: BottomNavigationBarType.fixed,
          onTap: changeTab,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home_outlined),
              activeIcon: const Icon(Icons.home),
              label: LocaleKeys.home.tr(),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.grid_view_outlined),
              activeIcon: const Icon(Icons.grid_view_rounded),
              label: LocaleKeys.categories.tr(),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.search_outlined),
              activeIcon: const Icon(Icons.search),
              label: LocaleKeys.search.tr(),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.shopping_cart_outlined),
              activeIcon: const Icon(Icons.shopping_cart),
              label: LocaleKeys.cart.tr(),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.person_outline),
              activeIcon: const Icon(Icons.person),
              label: LocaleKeys.account.tr(),
            ),
          ],
        ),
        body: screens[activeindex],
      ),
    );
  }
}