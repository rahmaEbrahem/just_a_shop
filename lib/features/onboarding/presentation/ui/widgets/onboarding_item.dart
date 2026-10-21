import 'package:e_commerce_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingItem extends StatelessWidget {
  final String image;
  final String title;
  final String decription;
  const OnboardingItem({
    super.key,
    required this.image,
    required this.title,
    required this.decription,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 400.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColor.darkmode,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
          ),
          child: Image.asset(image, fit: BoxFit.contain),
        ),
        20.verticalSpace,
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.headlineMedium?.copyWith(color: AppColor.secondarycolor),
          textAlign: TextAlign.center,
        ),
        20.verticalSpace,
        Text(
          decription,
          style: Theme.of(
            context,
          ).textTheme.titleSmall?.copyWith(color: AppColor.containercolor),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
