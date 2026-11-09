import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e_commerce_app/core/app_widgets/app_text_field.dart';
import 'package:e_commerce_app/features/auth/register/presentation/ui/widget/subtitles.dart';
import 'package:e_commerce_app/gen/locale_keys.g.dart';

class RegisterFormFields extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController addressController;
  final TextEditingController cityController;
  final TextEditingController countryController;

  const RegisterFormFields({
    super.key,
    required this.nameController,
    required this.firstNameController,
    required this.lastNameController,
    required this.emailController,
    required this.passwordController,
    required this.addressController,
    required this.cityController,
    required this.countryController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Subtitles(subtitle: LocaleKeys.nametitle.tr()),
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
        Subtitles(subtitle: LocaleKeys.firstname.tr()),
        10.verticalSpace,
        AppTextField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return LocaleKeys.firstfield.tr();
            }
            return null;
          },
          controller: firstNameController,
          text: LocaleKeys.firstfield.tr(),
          keyboardtype: TextInputType.name,
        ),
        10.verticalSpace,
        Subtitles(subtitle: LocaleKeys.lastname.tr()),
        10.verticalSpace,
        AppTextField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return LocaleKeys.lastfield.tr();
            }
            return null;
          },
          controller: lastNameController,
          text: LocaleKeys.lastfield.tr(),
          keyboardtype: TextInputType.name,
        ),
        10.verticalSpace,
        Subtitles(subtitle: LocaleKeys.emailtitle.tr()),
        10.verticalSpace,
        AppTextField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return LocaleKeys.emailcheck.tr();
            }
            if (!value.contains('@')) {
              return LocaleKeys.validemail.tr();
            }
            return null;
          },
          controller: emailController,
          text: LocaleKeys.emailfield.tr(),
          keyboardtype: TextInputType.emailAddress,
        ),
        10.verticalSpace,
        Subtitles(subtitle: LocaleKeys.passwordtitle.tr()),
        10.verticalSpace,
        AppTextField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return LocaleKeys.passcheck.tr();
            }
            if (value.length < 6) {
              return LocaleKeys.passrole.tr();
            }
            return null;
          },
          controller: passwordController,
          text: LocaleKeys.paswordfield.tr(),
          keyboardtype: TextInputType.visiblePassword,
          ispassword: true,
        ),
        10.verticalSpace,
        Subtitles(subtitle: LocaleKeys.adress.tr()),
        10.verticalSpace,
        AppTextField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return LocaleKeys.adressfield.tr();
            }
            return null;
          },
          controller: addressController,
          text: LocaleKeys.adressfield.tr(),
          keyboardtype: TextInputType.streetAddress,
        ),
        10.verticalSpace,
        Subtitles(subtitle: LocaleKeys.city.tr()),
        10.verticalSpace,
        AppTextField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return LocaleKeys.cityfiled.tr();
            }
            return null;
          },
          controller: cityController,
          text: LocaleKeys.cityfiled.tr(),
          keyboardtype: TextInputType.name,
        ),
        10.verticalSpace,
        Subtitles(subtitle: LocaleKeys.country.tr()),
        10.verticalSpace,
        AppTextField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return LocaleKeys.countryfield.tr();
            }
            return null;
          },
          controller: countryController,
          text: LocaleKeys.countryfield.tr(),
          keyboardtype: TextInputType.name,
        ),
      ],
    );
  }
}