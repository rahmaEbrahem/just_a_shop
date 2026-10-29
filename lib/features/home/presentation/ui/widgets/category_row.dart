import 'package:e_commerce_app/core/app_widgets/app_bottom_nav_bar.dart';
import 'package:e_commerce_app/core/theme/app_colors.dart';
import 'package:e_commerce_app/features/categories/presentation/cubit/category_cubit.dart';
import 'package:e_commerce_app/gen/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryRow extends StatelessWidget {
  const CategoryRow({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        if (state is CategoryLoading) {
          return const Center(child: CircularProgressIndicator());
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
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        AppBottomNavBar.navigateToCategories(context);
                      },
                      child: Text(
                        LocaleKeys.seeall.tr(),
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(color: AppColor.secondarycolor),
                      ),
                    ),
                  ),
                ],
              ),
              20.verticalSpace,
              SizedBox(
                height: 50.h,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  separatorBuilder: (context, index) => SizedBox(width: 12.w),
                  itemBuilder: (context, index) {
                    return Container(
                      width: 130.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColor.maincolor,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: AppColor.bordercolor),
                      ),
                      child: Text(
                        categories[index],
                        softWrap: true,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: AppColor.lightmode,
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
        return const SizedBox.shrink();
      },
    );
  }
}
