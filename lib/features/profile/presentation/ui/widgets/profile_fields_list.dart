import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:e_commerce_app/gen/locale_keys.g.dart';
import 'profile_read_only_field.dart';
import 'profile_editable_field.dart';

class ProfileFieldsList extends StatelessWidget {
  final dynamic user;
  final TextEditingController countryController;
  final TextEditingController cityController;
  final TextEditingController addressController;
  final FocusNode countryFocusNode;
  final FocusNode cityFocusNode;
  final FocusNode addressFocusNode;
  final String? editingField;
  final Function(String, FocusNode) onToggleEdit;

  const ProfileFieldsList({
    super.key,
    required this.user,
    required this.countryController,
    required this.cityController,
    required this.addressController,
    required this.countryFocusNode,
    required this.cityFocusNode,
    required this.addressFocusNode,
    required this.editingField,
    required this.onToggleEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfileReadOnlyField(
          label: LocaleKeys.firstname.tr(),
          value: user.firstName,
        ),
        ProfileReadOnlyField(
          label: LocaleKeys.lastname.tr(),
          value: user.lastName,
        ),
        ProfileReadOnlyField(
          label: LocaleKeys.nametitle.tr(),
          value: user.username,
        ),
        ProfileReadOnlyField(
          label: LocaleKeys.emailtitle.tr(),
          value: user.email,
        ),
        ProfileEditableField(
          label: LocaleKeys.country.tr(),
          controller: countryController,
          focusNode: countryFocusNode,
          isEditing: editingField == LocaleKeys.country.tr(),
          onToggleEdit: () => onToggleEdit(LocaleKeys.country.tr(), countryFocusNode),
        ),
        ProfileEditableField(
          label: LocaleKeys.city.tr(),
          controller: cityController,
          focusNode: cityFocusNode,
          isEditing: editingField == LocaleKeys.city.tr(),
          onToggleEdit: () => onToggleEdit(LocaleKeys.city.tr(), cityFocusNode),
        ),
        ProfileEditableField(
          label: LocaleKeys.adress.tr(),
          controller: addressController,
          focusNode: addressFocusNode,
          isEditing: editingField == LocaleKeys.adress.tr(),
          onToggleEdit: () => onToggleEdit(LocaleKeys.adress.tr(), addressFocusNode),
        ),
      ],
    );
  }
}