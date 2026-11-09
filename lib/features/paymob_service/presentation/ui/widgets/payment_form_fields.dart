import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:e_commerce_app/features/paymob_service/presentation/ui/widgets/custom_text_form_field.dart';

class PaymentFormFields extends StatelessWidget {
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController addressController;

  const PaymentFormFields({
    super.key,
    required this.firstNameController,
    required this.lastNameController,
    required this.emailController,
    required this.phoneController,
    required this.addressController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextFormField(
          controller: firstNameController,
          labelText: 'First Name'.tr(),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please enter your first name'.tr();
            }
            return null;
          },
        ),
        CustomTextFormField(
          controller: lastNameController,
          labelText: 'Last Name'.tr(),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please enter your last name'.tr();
            }
            return null;
          },
        ),
        CustomTextFormField(
          controller: emailController,
          labelText: 'Email'.tr(),
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please enter your email'.tr();
            }
            return null;
          },
        ),
        CustomTextFormField(
          controller: phoneController,
          labelText: 'Phone Number'.tr(),
          keyboardType: TextInputType.phone,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please enter your phone number';
            }
            return null;
          },
        ),
        CustomTextFormField(
          controller: addressController,
          labelText: 'Address'.tr(),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please enter your address'.tr();
            }
            return null;
          },
        ),
      ],
    );
  }
}