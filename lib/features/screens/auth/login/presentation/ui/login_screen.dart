import 'package:e_commerce_app/core/app_widgets/app_container.dart';
import 'package:e_commerce_app/core/app_widgets/app_text_field.dart';
import 'package:e_commerce_app/core/app_widgets/auth_container.dart';
import 'package:e_commerce_app/core/app_widgets/divider/auth_divider.dart';
import 'package:e_commerce_app/core/helper/extentions/extension.dart';
import 'package:e_commerce_app/core/routes/routes.dart';
import 'package:e_commerce_app/core/theme/app_colors.dart';
import 'package:e_commerce_app/features/screens/auth/login/login_with_facebook/login_with_facebook.dart';
import 'package:e_commerce_app/features/screens/auth/login/login_with_google/login_with_google.dart';
import 'package:e_commerce_app/gen/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formkey = GlobalKey<FormState>();
  var passwordcontroller = TextEditingController();
  var emailcontroller = TextEditingController();

  @override
  void dispose() {
    emailcontroller.dispose();
    passwordcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Form(
            key: formkey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  20.verticalSpace,
                  Text(
                    LocaleKeys.loginaccount.tr(),
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  20.verticalSpace,
                  Text(
                    LocaleKeys.welcometitle.tr(),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  40.verticalSpace,
                  Text(
                    LocaleKeys.emailtitle.tr(),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  10.verticalSpace,
                  AppTextField(
                    controller: emailcontroller,
                    text: LocaleKeys.emailfield.tr(),
                    keyboardtype: TextInputType.emailAddress,
                  ),
                  10.verticalSpace,
                  Text(
                    LocaleKeys.passwordtitle.tr(),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  10.verticalSpace,
                  AppTextField(
                    controller: passwordcontroller,
                    text: LocaleKeys.paswordfield.tr(),
                    keyboardtype: TextInputType.visiblePassword,
                    ispassword: true,
                  ),
                  40.verticalSpace,
                  AppContainer(text: LocaleKeys.logintitle.tr(), onTap: () {}),
                  20.verticalSpace,
                  AuthDivider(),
                  30.verticalSpace,
                  AuthContainer(
                    text: LocaleKeys.googlelogin.tr(),
                    onTap: () async {
                      await signInWithGoogle();
                    },
                    containcolor: Colors.white,
                    icon: 'assets/icons/google-icon-logo-svgrepo-com.svg',
                  ),
                  20.verticalSpace,
                  AuthContainer(
                    text: LocaleKeys.facelogin.tr(),
                    onTap: () async {
                      var user = await signInWithFacebook();
                      if (user != null) {
                        print('مرحباً بكِ، تم تسجيل الدخول بواسطة: ${user.email}');
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                           SnackBar(
                            content: Text('فشل تسجيل الدخول بواسطة فيسبوك، حاول مرة أخرى'),
                            backgroundColor:AppColor.containercolor,
                          ),
                        );
                      }
                    }, 
                    containcolor: AppColor.secondarycolor,
                    icon: 'assets/icons/facebook-3-logo-svgrepo-com.svg',
                  ),
                  30.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        LocaleKeys.signuptitle.tr(),
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      5.horizontalSpace,
                      InkWell(
                        onTap: () {
                          context.pushNamed(Routes.registerscreen);
                        },
                        child: Text(
                          LocaleKeys.signup.tr(),
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}