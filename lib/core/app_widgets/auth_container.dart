import 'package:e_commerce_app/core/theme/app_colors.dart';
import 'package:e_commerce_app/gen/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class AuthContainer extends StatelessWidget {
  final String text;
  final String icon;
  final Color containcolor;
  final void Function()? onTap;
  final bool isLoading;
  final bool enabled;

  const AuthContainer({
    super.key,
    required this.text,
    required this.onTap,
    required this.containcolor,
    required this.icon,
    this.isLoading = false,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled && !isLoading ? onTap : null,
      child: Container(
        width: 341.w,
        height: 60.h,
        decoration: BoxDecoration(
          color: containcolor,
          border: Border.all(color: AppColor.bordercolor),
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLoading) ...[
              SizedBox(
                width: 22.w,
                height: 22.h,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: AppColor.darkmode,
                ),
              ),
              10.horizontalSpace,
              Text(
                text,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(color: AppColor.darkmode),
              ),
            ] else ...[
              Text(
                text,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(color: AppColor.darkmode),
              ),
              5.horizontalSpace,
              SvgPicture.asset(icon, height: 40.h),
            ],
          ],
        ),
      ),
    );
  }
}
