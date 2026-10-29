import 'package:e_commerce_app/core/app_widgets/divider/app_divider.dart';
import 'package:e_commerce_app/core/theme/app_colors.dart';
import 'package:e_commerce_app/features/categories/presentation/ui/widgets/category_bloc_builder.dart';
import 'package:e_commerce_app/gen/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoriesSceens extends StatelessWidget {
  const CategoriesSceens({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: ListView(
          children: [
            Column(
              children: [
                10.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      LocaleKeys.categories,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppColor.maincolor,
                      ),
                    ),
                  ],
                ),
                10.verticalSpace,
                AppDivider(),
                20.verticalSpace,
                CategoryBlocBuilder(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
