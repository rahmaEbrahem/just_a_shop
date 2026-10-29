import 'package:e_commerce_app/core/helper/extentions/extension.dart';
import 'package:e_commerce_app/core/theme/app_colors.dart';
import 'package:e_commerce_app/features/home/presentation/ui/widgets/product_sort_order.dart';
import 'package:e_commerce_app/gen/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SortingContainer extends StatelessWidget {
  final ValueChanged<ProductSortOrder> onSortingSelected;
  const SortingContainer({super.key, required this.onSortingSelected});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(15.r),
      child: InkWell(
        borderRadius: BorderRadius.circular(15.r),
        onTap: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return Material(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          LocaleKeys.sortproducts.tr(),
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        15.verticalSpace,
                        ListTile(
                          leading: Icon(Icons.arrow_downward),
                          title: Text(LocaleKeys.Pricelow.tr()),
                          onTap: () {
                            context.pop();
                            onSortingSelected(ProductSortOrder.priceLowToHigh);
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.arrow_upward),
                          title: Text(LocaleKeys.pricehigh.tr()),
                          onTap: () {
                            context.pop();
                            onSortingSelected(ProductSortOrder.priceHighToLow);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
        child: Container(
          height: 50.h,
          width: 50.w,
          decoration: BoxDecoration(
            color: AppColor.searchcolor,
            border: Border.all(color: AppColor.bordercolor),
            borderRadius: BorderRadius.circular(15.r),
          ),
          child: Icon(Icons.sort, color: AppColor.darkmode),
        ),
      ),
    );
  }
}
