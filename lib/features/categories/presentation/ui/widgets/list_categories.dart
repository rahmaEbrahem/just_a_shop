import 'package:e_commerce_app/core/theme/app_colors.dart';
import 'package:e_commerce_app/features/categories/presentation/ui/category_icons.dart';
import 'package:e_commerce_app/features/products/presentation/ui/category_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ListCategories extends StatelessWidget {
  final List<String> categories;
  const ListCategories({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: categories.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 12.h,
        childAspectRatio: 1.4.h,
      ),
      itemBuilder: (context, index) {
        final catrgory = categories[index];
        final iconpath = categoryicons[catrgory.toLowerCase()];
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    CategoryProductsScreen(category: categories[index]),
              ),
            );
          },
          child: Container(
            height: 200.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColor.violetcolor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColor.searchcolor),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  15.verticalSpace,
                  iconpath != null
                      ? SvgPicture.asset(
                          iconpath,
                          fit: BoxFit.contain,
                          height: 52,
                          width: 52,
                        )
                      : Icon(Icons.category_outlined),
                  8.verticalSpace,

                  Text(
                    categories[index],
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(
                      context,
                    ).textTheme.titleSmall?.copyWith(color: AppColor.lightmode),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
