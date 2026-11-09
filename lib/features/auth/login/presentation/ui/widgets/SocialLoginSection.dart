import 'package:flutter/material.dart';
import 'package:e_commerce_app/core/app_widgets/auth_container.dart';
import 'package:e_commerce_app/core/theme/app_colors.dart';
import 'package:e_commerce_app/gen/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SocialLoginSection extends StatelessWidget {
  final bool isGoogleLoading;
  final bool isFacebookLoading;
  final VoidCallback onGoogleLogin;
  final VoidCallback onFacebookLogin;

  const SocialLoginSection({
    super.key,
    required this.isGoogleLoading,
    required this.isFacebookLoading,
    required this.onGoogleLogin,
    required this.onFacebookLogin,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AuthContainer(
          text: isGoogleLoading ? 'Signing in...' : LocaleKeys.googlelogin.tr(),
          onTap: onGoogleLogin,
          isLoading: isGoogleLoading,
          enabled: !isFacebookLoading,
          containcolor: Colors.white,
          icon: 'assets/icons/google-icon-logo-svgrepo-com.svg',
        ),
        20.verticalSpace,
        AuthContainer(
          text: isFacebookLoading ? 'Signing in...' : LocaleKeys.facelogin.tr(),
          onTap: onFacebookLogin,
          isLoading: isFacebookLoading,
          enabled: !isGoogleLoading,
          containcolor: AppColor.secondarycolor,
          icon: 'assets/icons/facebook-3-logo-svgrepo-com.svg',
        ),
      ],
    );
  }
}