import 'package:e_commerce_app/core/app_widgets/divider/app_divider.dart';
import 'package:e_commerce_app/core/secure_storage/user_storage.dart';
import 'package:e_commerce_app/core/theme/app_colors.dart';
import 'package:e_commerce_app/gen/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String?>>(
      future: Future.wait([
        UserStorage.getFirstName(),
        UserStorage.getLastName(),
        UserStorage.getUserName(),
        UserStorage.getEmail(),
      ]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final data = snapshot.data;

        final firstName = data?[0] ?? '';
        final lastName = data?[1] ?? '';
        final username = data?[2] ?? '';
        final email = data?[3] ?? '';

        final fullName = '$firstName $lastName'.trim();
        final displayName = fullName.isNotEmpty
            ? fullName
            : username.isNotEmpty
            ? username
            : 'User';

        return Column(
          children: [
            30.verticalSpace,
            CircleAvatar(
              radius: 42,
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              child: Icon(
                Icons.person_outline,
                size: 45,
                color: AppColor.maincolor,
              ),
            ),
            12.verticalSpace,
            Text(displayName, style: Theme.of(context).textTheme.titleLarge),
            4.verticalSpace,
            Text(
              email,
              style: Theme.of(
                context,
              ).textTheme.titleSmall?.copyWith(color: AppColor.bordercolor),
            ),
          ],
        );
      },
    );
  }
}
