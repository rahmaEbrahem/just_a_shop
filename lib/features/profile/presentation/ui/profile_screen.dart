import 'package:e_commerce_app/core/app_widgets/divider/app_divider.dart';
import 'package:e_commerce_app/core/helper/extentions/extension.dart';
import 'package:e_commerce_app/core/routes/routes.dart';
import 'package:e_commerce_app/features/profile/presentation/ui/widgets/language_dialog.dart';
import 'package:e_commerce_app/features/profile/presentation/ui/widgets/profile_header.dart';
import 'package:e_commerce_app/features/profile/presentation/ui/widgets/profile_menu_item.dart';
import 'package:e_commerce_app/features/profile/presentation/ui/widgets/profile_section_title.dart';
import 'package:e_commerce_app/features/profile/presentation/ui/widgets/theme_dialog.dart';
import 'package:e_commerce_app/gen/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: ProfileHeader()),

            28.verticalSpace,
            AppDivider(),

            ProfileSectionTitle(title: LocaleKeys.profile.tr()),

            ProfileMenuItem(
              icon: Icons.person_outline,
              title: LocaleKeys.personalinformation.tr(),
              onTap: () {
                context.pushNamed(Routes.profileinfoscreen);
              },
            ),

            12.verticalSpace,
            AppDivider(),
            12.verticalSpace,
            ProfileSectionTitle(title: LocaleKeys.setting.tr()),

            ProfileMenuItem(
              icon: Icons.language,
              title: LocaleKeys.chooselanguage.tr(),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (dialogContext) {
                    return const LanguageDialog();
                  },
                );
              },
            ),

            ProfileMenuItem(
              icon: Icons.dark_mode_outlined,
              title: LocaleKeys.choosetheme.tr(),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) => const ThemeDialog(),
                );
              },
            ),

            16.verticalSpace,
            AppDivider(),

            ProfileMenuItem(
              icon: Icons.logout,
              title: LocaleKeys.logout.tr(),
              iconColor: Theme.of(context).colorScheme.error,
              trailing: const SizedBox.shrink(),
              onTap: () {
                // We will implement logout after reviewing auth flow.
              },
            ),
          ],
        ),
      ),
    );
  }
}
