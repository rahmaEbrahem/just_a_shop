import 'package:e_commerce_app/core/app_widgets/app_bottom_nav_bar.dart';
import 'package:e_commerce_app/core/theme/app_colors.dart';
import 'package:e_commerce_app/features/categories/presentation/cubit/category_cubit.dart';
import 'package:e_commerce_app/features/categories/presentation/ui/category_icons.dart';
import 'package:e_commerce_app/features/products/presentation/ui/category_product_screen.dart';
import 'package:e_commerce_app/gen/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CategoryRow extends StatelessWidget {
  const CategoryRow({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        if (state is CategoryLoading) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is CategorySuccess) {
          final categories = state.categories.take(5).toList();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    LocaleKeys.categories.tr(),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),

                  InkWell(
                    onTap: () {
                      AppBottomNavBar.navigateToCategories(context);
                    },
                    child: Text(
                      LocaleKeys.seeall.tr(),
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColor.maincolor,
                      ),
                    ),
                  ),
                ],
              ),
              20.verticalSpace,
              SizedBox(
                height: 100.h,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  separatorBuilder: (context, index) => SizedBox(width: 12.w),
                  itemBuilder: (context, index) {
                    final catrgory = categories[index];
                    final iconpath = categoryicons[catrgory.toLowerCase()];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CategoryProductsScreen(
                              category: categories[index],
                            ),
                          ),
                        );
                      },
                      child: Container(
                        height: 90.h,
                        width: 130.w,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColor.violetcolor,
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(color: AppColor.searchcolor),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            15.verticalSpace,
                            iconpath != null
                                ? SvgPicture.asset(
                                    iconpath,
                                    fit: BoxFit.contain,
                                    height: 32,
                                    width: 32,
                                  )
                                : Icon(Icons.category_outlined),

                            Text(
                              categories[index],
                              softWrap: true,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.titleSmall
                                  ?.copyWith(color: AppColor.lightmode),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }
        if (state is CategoryError) {
          return Text(state.failure.failureMessage);
        }
        return SizedBox.shrink();
      },
    );
  }
}
