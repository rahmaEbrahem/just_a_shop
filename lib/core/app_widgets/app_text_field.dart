import 'package:e_commerce_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatefulWidget {
  final String text;
  final TextInputType keyboardtype;
  final ispassword;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  const AppTextField({
    super.key,
    required this.text,
    required this.keyboardtype,
    this.ispassword = false,
    this.controller,
    this.validator,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool isobscure = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      controller: widget.controller,
      keyboardType: widget.keyboardtype,
      obscureText: widget.ispassword && isobscure,
      decoration: InputDecoration(
        suffixIcon: widget.ispassword
            ? InkWell(
                onTap: () {
                  setState(() {
                    isobscure = !isobscure;
                  });
                },
                child: Icon(
                  isobscure ? Icons.visibility : Icons.visibility_off,
                ),
              )
            : null,
        hint: Text(widget.text),
        hintStyle: Theme.of(
          context,
        ).textTheme.titleSmall?.copyWith(color: AppColor.containercolor),
      ),
      onTapOutside: (v) {
        FocusScope.of(context).unfocus();
      },
    );
  }
}
