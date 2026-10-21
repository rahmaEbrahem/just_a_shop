import 'package:e_commerce_app/core/app_widgets/app_bottom_nav_bar.dart';
import 'package:e_commerce_app/core/theme/app_colors.dart';
import 'package:e_commerce_app/gen/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        AppBottomNavBar.navigateToSearch(context);
      },
      child: Container(
        height: 50.h,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          border: BoxBorder.all(color: AppColor.bordercolor),
          color: AppColor.searchcolor,
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Row(
          children: [
            10.horizontalSpace,
            Icon(Icons.search_outlined, color: AppColor.darkmode),
            20.horizontalSpace,
            Text(
              LocaleKeys.searchproduct.tr(),
              style: Theme.of(
                context,
              ).textTheme.titleSmall?.copyWith(color: AppColor.bordercolor),
            ),
          ],
        ),
      ),
    );
  }
}
