import 'package:e_commerce_app/core/app_widgets/app_bottom_nav_bar.dart';
import 'package:e_commerce_app/core/theme/app_colors.dart';
import 'package:e_commerce_app/features/search/presentation/cubit/product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HeaderSearchScreen extends StatelessWidget {
  const HeaderSearchScreen({super.key});
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
                "Search",
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
            onFieldSubmitted: (value) async {
              if (value.trim().isNotEmpty) {
                context.read<ProductCubit>().searchProducts(value);
                final prefs = await SharedPreferences.getInstance();
                List<String> searches =
                    prefs.getStringList('recent_searches_key') ?? [];

                if (searches.contains(value)) {
                  searches.remove(value);
                }
                searches.insert(0, value);

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
              suffixIcon: Icon(Icons.mic_none),
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
