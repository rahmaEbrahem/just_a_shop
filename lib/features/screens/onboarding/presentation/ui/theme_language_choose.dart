import 'package:e_commerce_app/core/app_widgets/app_container.dart';
import 'package:e_commerce_app/core/helper/extentions/extension.dart';
import 'package:e_commerce_app/core/routes/app_routes.dart';
import 'package:e_commerce_app/core/routes/routes.dart';
import 'package:e_commerce_app/core/storage/settings_model.dart';
import 'package:e_commerce_app/core/storage/settings_storage.dart';
import 'package:e_commerce_app/core/theme/app_colors.dart';
import 'package:e_commerce_app/core/theme/app_theme.dart';
import 'package:e_commerce_app/core/theme/cubit/theme_cubit.dart';
import 'package:e_commerce_app/features/screens/onboarding/presentation/ui/widgets/custom_container.dart';
import 'package:e_commerce_app/gen/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ThemeLanguageChoose extends StatefulWidget {
  const ThemeLanguageChoose({super.key});

  @override
  State<ThemeLanguageChoose> createState() => _ThemeLanguageChooseState();
}

class _ThemeLanguageChooseState extends State<ThemeLanguageChoose> {
  String selectedLanguage = 'en';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              80.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "JUST  A  SHOP",
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: AppColor.maincolor,
                    ),
                  ),
                ],
              ),
              100.verticalSpace,
              Text(
                LocaleKeys.chooselanguage.tr(),
                style: Theme.of(context).textTheme.titleLarge,
              ),
              20.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomContainer(
                    text: 'English',
                    isSelected: context.locale.languageCode == "en",
                    onTap: () {
                      context.setLocale(const Locale('en'));
                    },
                  ),
                  15.horizontalSpace,
                  CustomContainer(
                    text: 'العربية',
                    isSelected: context.locale.languageCode == "ar",
                    onTap: () {
                      context.setLocale(const Locale('ar'));
                    },
                  ),
                ],
              ),
              30.verticalSpace,
              Text(
                LocaleKeys.choosetheme.tr(),
                style: Theme.of(context).textTheme.titleLarge,
              ),
              20.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomContainer(
                    text: LocaleKeys.light.tr(),
                    isSelected:
                        context.read<ThemeCubit>().apptheme ==
                        AppTheme.lightthem,
                    onTap: () {
                      context.read<ThemeCubit>().setTheme('light');
                    },
                  ),
                  15.horizontalSpace,
                  CustomContainer(
                    text: LocaleKeys.dark.tr(),
                    isSelected:
                        context.read<ThemeCubit>().apptheme ==
                        AppTheme.darkthem,
                    onTap: () {
                      context.read<ThemeCubit>().setTheme('dark');
                    },
                  ),
                ],
              ),
              100.verticalSpace,
              AppContainer(
                text: LocaleKeys.continuetext.tr(),
                onTap: () async {
                  final settings = SettingsStorage();

                  final currentSettings = settings.getSettings();

                  final updatedSettings = SettingsModel(
                    languagecode: selectedLanguage,
                    themeMode: currentSettings?.themeMode ?? 'light',
                  );

                  await settings.SaveSettings(updatedSettings);
                  context.pushNamed(Routes.onboarding);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
