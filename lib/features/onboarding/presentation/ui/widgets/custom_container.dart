import 'package:e_commerce_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomContainer extends StatelessWidget {
  final String text;
  final IconData? icon;
  final bool isSelected;
  final void Function()? onTap;

  const CustomContainer({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onTap,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150.w,
        height: 80.h,
        decoration: BoxDecoration(
          color: isSelected ? AppColor.maincolor : AppColor.containercolor,
          borderRadius: BorderRadius.circular(18.r),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Icon(icon, size: 30),
                5.horizontalSpace,
                Text(text, style: Theme.of(context).textTheme.titleLarge),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
