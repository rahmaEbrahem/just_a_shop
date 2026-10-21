import 'package:e_commerce_app/core/secure_storage/user_storage.dart';
import 'package:e_commerce_app/core/theme/app_colors.dart';
import 'package:e_commerce_app/gen/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: UserStorage.getFirstName(),
      builder: (context, snapshot) {
        final firstname = snapshot.data!.trim().split(RegExp(r'\s+')).first;
        return Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.home, size: 45, color: AppColor.maincolor),

                10.horizontalSpace,

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    5.verticalSpace,
                    Text(
                      LocaleKeys.welcome.tr(
                        args: [
                          firstname.isNotEmpty == true ? firstname : 'there',
                        ],
                      ),
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColor.secondarycolor,
                      ),
                    ),

                    3.verticalSpace,
                    Text(
                      LocaleKeys.discovertitle.tr(),
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: AppColor.bordercolor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
