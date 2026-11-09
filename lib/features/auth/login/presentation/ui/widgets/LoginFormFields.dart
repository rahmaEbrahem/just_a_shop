import 'package:flutter/material.dart';
import 'package:e_commerce_app/core/app_widgets/app_text_field.dart';
import 'package:e_commerce_app/gen/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginFormFields extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController passwordController;

  const LoginFormFields({
    super.key,
    required this.nameController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.nametitle.tr(),
          style: Theme.of(context).textTheme.titleLarge,
        ),
        10.verticalSpace,
        AppTextField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return LocaleKeys.namefield.tr();
            }
            return null;
          },
          controller: nameController,
          text: LocaleKeys.namefield.tr(),
          keyboardtype: TextInputType.name,
        ),
        10.verticalSpace,
        Text(
          LocaleKeys.passwordtitle.tr(),
          style: Theme.of(context).textTheme.titleLarge,
        ),
        10.verticalSpace,
        AppTextField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your password';
            }
            if (value.length < 6) {
              return 'Password must be at least 6 characters';
            }
            return null;
          },
          controller: passwordController,
          text: LocaleKeys.paswordfield.tr(),
          keyboardtype: TextInputType.visiblePassword,
          ispassword: true,
        ),
      ],
    );
  }
}