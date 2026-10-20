import 'package:e_commerce_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IndicatorContainer extends StatelessWidget {
  final bool isSelected;
  const IndicatorContainer({super.key, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10.w,
      height: 10.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isSelected ? AppColor.maincolor : AppColor.bordercolor,
      ),
    );
  }
}
