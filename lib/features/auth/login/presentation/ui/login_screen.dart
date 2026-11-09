import 'package:e_commerce_app/core/app_widgets/app_container.dart';
import 'package:e_commerce_app/core/app_widgets/divider/auth_divider.dart';
import 'package:e_commerce_app/core/helper/extentions/extension.dart';
import 'package:e_commerce_app/core/routes/routes.dart';
import 'package:e_commerce_app/core/theme/app_colors.dart';
import 'package:e_commerce_app/features/auth/login/login_with_facebook/login_with_facebook.dart';
import 'package:e_commerce_app/features/auth/login/login_with_google/login_with_google.dart';
import 'package:e_commerce_app/features/auth/login/presentation/cubit/login_cubit.dart';
import 'package:e_commerce_app/features/auth/login/presentation/ui/widgets/LoginFormFields.dart';
import 'package:e_commerce_app/features/auth/login/presentation/ui/widgets/SocialLoginSection.dart';
import 'package:e_commerce_app/features/auth/login/presentation/ui/widgets/login_bloc_listener.dart';
import 'package:e_commerce_app/gen/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formkey = GlobalKey<FormState>();
  var passwordcontroller = TextEditingController();
  var namecontroller = TextEditingController();

  bool isGoogleLoading = false;
  bool isFacebookLoading = false;

  @override
  void dispose() {
    namecontroller.dispose();
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
                  const LoginBlocListener(),
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

                    LoginFormFields(
                    nameController: namecontroller,
                    passwordController: passwordcontroller,
                  ),

                  40.verticalSpace,
                  AppContainer(
                    text: LocaleKeys.logintitle.tr(),
                    onTap: () {
                      if (formkey.currentState!.validate()) {
                        context.read<LoginCubit>().login(
                          namecontroller.text.trim(),
                          passwordcontroller.text,
                        );
                      }
                    },
                  ),
                  20.verticalSpace,
                  const AuthDivider(),
                  30.verticalSpace,
                  SocialLoginSection(
                    isGoogleLoading: isGoogleLoading,
                    isFacebookLoading: isFacebookLoading,
                    onGoogleLogin: () async {
                      if (isGoogleLoading || isFacebookLoading) return;
                      setState(() => isGoogleLoading = true);
                      try {
                        await signInWithGoogle(context);
                      } finally {
                        if (mounted) setState(() => isGoogleLoading = false);
                      }
                    },
                    onFacebookLogin: () async {
                      if (isGoogleLoading || isFacebookLoading) return;
                      setState(() => isFacebookLoading = true);
                      try {
                        final user = await signInWithFacebook(context);
                        if (!mounted) return;
                        if (user != null) {
                          debugPrint('Facebook login successful: ${user.email}');
                          return;
                        }
                        if (pendingFacebookCredential != null) {
                          final shouldContinue = await showDialog<bool>(
                            context: context,
                            builder: (dialogContext) {
                              return AlertDialog(
                                title: Text(LocaleKeys.accountAlreadyExists.tr()),
                                content: Text(LocaleKeys.accountAlreadyExistsMessage.tr()),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.of(dialogContext).pop(false),
                                    child: Text(LocaleKeys.cancel.tr()),
                                  ),
                                  ElevatedButton(
                                    onPressed: () => Navigator.of(dialogContext).pop(true),
                                    child: Text(LocaleKeys.continueWithGoogle.tr()),
                                  ),
                                ],
                              );
                            },
                          );
                          if (!mounted) return;
                          if (shouldContinue == true) {
                            if (isGoogleLoading) return;
                            setState(() {
                              isFacebookLoading = false;
                              isGoogleLoading = true;
                            });
                            try {
                              await signInWithGoogle(context);
                            } finally {
                              if (mounted) setState(() => isGoogleLoading = false);
                            }
                          }
                          return;
                        }
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(LocaleKeys.facebookLoginFailed.tr()),
                            backgroundColor: AppColor.containercolor,
                          ),
                        );
                      } catch (e) {
                        debugPrint('Facebook login error: $e');
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(LocaleKeys.facebookLoginFailed.tr()),
                              backgroundColor: AppColor.containercolor,
                            ),
                          );
                        }
                      } finally {
                        if (mounted) setState(() => isFacebookLoading = false);
                      }
                    },
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