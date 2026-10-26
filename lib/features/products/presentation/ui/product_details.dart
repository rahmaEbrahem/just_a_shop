import 'package:e_commerce_app/core/theme/app_colors.dart';
import 'package:e_commerce_app/features/products/data/model/product_model.dart';
import 'package:e_commerce_app/features/products/presentation/ui/widgets/add_cart.dart';
import 'package:e_commerce_app/gen/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductDetails extends StatelessWidget {
  final ProductModel product;

  const ProductDetails({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          LocaleKeys.productdetails.tr(),
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(color: AppColor.secondarycolor),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              product.thumbnail ?? '',
              width: double.infinity,
              height: 300,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return const SizedBox(
                  height: 300,
                  child: Center(
                    child: Icon(Icons.image_not_supported, size: 50),
                  ),
                );
              },
            ),
            20.verticalSpace,

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title ?? '',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),

                  20.verticalSpace,

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${product.price?.toStringAsFixed(2) ?? '0.00'}',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      12.horizontalSpace,
                      Text(
                        '${product.discountPercentage?.toStringAsFixed(0) ?? '0'}% OFF',
                        style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  20.verticalSpace,
                  Text(
                    LocaleKeys.description_details.tr(),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  15.verticalSpace,

                  Text(
                    product.description ?? '',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  20.verticalSpace,

                  Text(
                    '${LocaleKeys.category.tr()}: ${product.category ?? 'N/A'}',
                  ),

                  10.verticalSpace,

                  Text('${LocaleKeys.weight.tr()}: ${product.weight ?? 'N/A'}'),

                  10.verticalSpace,

                  if (product.dimensions != null)
                    Text(
                      '${LocaleKeys.dimensions.tr()}:   '
                      'W : ${product.dimensions!.width ?? 0},   '
                      'H : ${product.dimensions!.height ?? 0},   '
                      'D : ${product.dimensions!.depth ?? 0}',
                    ),

                  10.verticalSpace,

                  Text(
                    '${LocaleKeys.returnPolicy.tr()}:  '
                    '${product.returnPolicy ?? 'N/A'}',
                  ),
                  30.verticalSpace,
                  AddCart(),
                  50.verticalSpace,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
