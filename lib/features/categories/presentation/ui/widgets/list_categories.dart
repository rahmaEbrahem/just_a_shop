import 'package:e_commerce_app/core/theme/app_colors.dart';
import 'package:e_commerce_app/features/products/presentation/ui/category_product_screen.dart';
import 'package:flutter/material.dart';

class ListCategories extends StatelessWidget {
  final List<String> categories;
  const ListCategories({super.key, required this.categories});
  IconData _getCategoryIcon(String category) {
    final name = category.toLowerCase();

    if (name.contains('beauty')) return Icons.face_retouching_natural;
    if (name.contains('fragrances')) return Icons.spa_outlined;
    if (name.contains('furniture')) return Icons.chair_outlined;
    if (name.contains('groceries')) return Icons.shopping_basket_outlined;
    if (name.contains('decoration')) return Icons.weekend_outlined;
    if (name.contains('kitchen')) return Icons.kitchen_outlined;
    if (name.contains('laptop') || name.contains('computer')) {
      return Icons.laptop_outlined;
    }
    if (name.contains('phone') || name.contains('mobile')) {
      return Icons.phone_android_outlined;
    }
    if (name.contains('shirt') || name.contains('clothing')) {
      return Icons.checkroom_outlined;
    }
    if (name.contains('shoe')) return Icons.directions_run_outlined;
    if (name.contains('watch')) return Icons.watch_outlined;
    if (name.contains('bag')) return Icons.shopping_bag_outlined;

    return Icons.category_outlined;
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: categories.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 2.5,
      ),
      itemBuilder: (context, index) {
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
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColor.searchcolor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColor.bordercolor),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: AppColor.bordercolor,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      _getCategoryIcon(categories[index]),
                      size: 20,
                      color: AppColor.lightmode,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      categories[index],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: AppColor.darkmode,
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 12,
                    color: AppColor.darkmode,
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
