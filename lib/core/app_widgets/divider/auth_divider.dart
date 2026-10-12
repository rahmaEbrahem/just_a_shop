import 'package:e_commerce_app/core/theme/app_colors.dart';
import 'package:e_commerce_app/gen/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AuthDivider extends StatelessWidget {
  const AuthDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider(color: AppColor.containercolor, thickness: 1)),
        Text(
          LocaleKeys.ortitle.tr(),
          style: Theme.of(
            context,
          ).textTheme.titleSmall?.copyWith(color: AppColor.containercolor),
        ),
        Expanded(child: Divider(color: AppColor.containercolor, thickness: 1)),
      ],
    );
  }
}
