import 'package:e_commerce_app/core/app_widgets/app_bottom_nav_bar.dart';
import 'package:e_commerce_app/core/theme/app_colors.dart';
import 'package:e_commerce_app/features/search/presentation/cubit/product_cubit.dart';
import 'package:e_commerce_app/gen/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HeaderSearchScreen extends StatefulWidget {
  final TextEditingController controller;
  const HeaderSearchScreen({super.key, required this.controller});

  @override
  State<HeaderSearchScreen> createState() => _HeaderSearchScreenState();
}

class _HeaderSearchScreenState extends State<HeaderSearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: IconButton(
                onPressed: () {
                  AppBottomNavBar.navigateToHome(context);
                },
                icon: Icon(Icons.arrow_back_ios),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 110),
              child: Text(
                LocaleKeys.search.tr(),
                style: TextStyle(
                  fontWeight: FontWeight(700),
                  fontSize: 25,
                  color: AppColor.maincolor,
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: TextFormField(
            controller: widget.controller,
            style: const TextStyle(color: Colors.black, fontSize: 14),
            onChanged: (value) {
              if (value.trim().isEmpty) {
                context.read<ProductCubit>().searchProducts('');
              }
            },
            onFieldSubmitted: (value) async {
              final query = value.trim();

              if (query.isNotEmpty) {
                context.read<ProductCubit>().searchProducts(query);

                final prefs = await SharedPreferences.getInstance();
                List<String> searches =
                    prefs.getStringList('recent_searches_key') ?? [];

                searches.remove(query);
                searches.insert(0, query);

                await prefs.setStringList('recent_searches_key', searches);
              }
            },
            onTapUpOutside: (event) {
              FocusScope.of(context).unfocus();
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              prefixIcon: Icon(Icons.search),
              hintText: "search",
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.grey, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.purple, width: 2),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
