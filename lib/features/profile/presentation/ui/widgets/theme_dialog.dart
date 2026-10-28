import 'package:e_commerce_app/core/theme/app_theme.dart';
import 'package:e_commerce_app/core/theme/cubit/theme_cubit.dart';
import 'package:e_commerce_app/gen/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeDialog extends StatelessWidget {
  const ThemeDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.read<ThemeCubit>();

    final currentTheme = themeCubit.apptheme == AppTheme.darkthem
        ? 'dark'
        : 'light';

    return AlertDialog(
      title: Text(LocaleKeys.choosetheme.tr()),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RadioGroup<String>(
            groupValue: currentTheme,
            onChanged: (value) {
              if (value == null) return;

              themeCubit.setTheme(value);
              Navigator.pop(context);
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RadioListTile<String>(
                  title: Text(LocaleKeys.light.tr()),
                  value: 'light',
                ),
                RadioListTile<String>(
                  title: Text(LocaleKeys.dark.tr()),
                  value: 'dark',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
