import 'package:e_commerce_app/core/routes/app_routes.dart';
import 'package:e_commerce_app/core/storage/settings_storage.dart';
import 'package:e_commerce_app/core/theme/cubit/theme_cubit.dart';
import 'package:e_commerce_app/features/screens/onboarding/presentation/ui/onboarding.dart';
import 'package:e_commerce_app/features/screens/onboarding/presentation/ui/theme_language_choose.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ECommerceApp extends StatelessWidget {
  const ECommerceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return BlocProvider(
          create: (context) => ThemeCubit(SettingsStorage())..getSavedTheme(),
          child: BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, State) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                onGenerateRoute: AppRoutes.onGenerateRoute,
                theme: context.read<ThemeCubit>().apptheme.copyWith(
                  textTheme: context
                      .read<ThemeCubit>()
                      .apptheme
                      .textTheme
                      .apply(
                        fontFamily: context.locale.languageCode == 'ar'
                            ? 'Cairo'
                            : 'Poppins',
                      ),
                ),
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: context.locale,
                home: ThemeLanguageChoose(),
              );
            },
          ),
        );
      },
    );
  }
}
