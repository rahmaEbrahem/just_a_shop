import 'package:e_commerce_app/core/app_widgets/app_container.dart';
import 'package:e_commerce_app/core/app_widgets/app_text_field.dart';
import 'package:e_commerce_app/core/app_widgets/auth_container.dart';
import 'package:e_commerce_app/core/app_widgets/divider/auth_divider.dart';
import 'package:e_commerce_app/core/helper/extentions/extension.dart';
import 'package:e_commerce_app/core/routes/routes.dart';
import 'package:e_commerce_app/core/theme/app_colors.dart';
import 'package:e_commerce_app/features/auth/login/login_with_facebook/login_with_facebook.dart';
import 'package:e_commerce_app/features/auth/login/login_with_google/login_with_google.dart';
import 'package:e_commerce_app/features/auth/register/data/api_data/model/register_req_model.dart';
import 'package:e_commerce_app/features/auth/register/presentation/cubit/register_cubit.dart';
import 'package:e_commerce_app/features/auth/register/presentation/ui/widget/register_bloc_listen.dart';
import 'package:e_commerce_app/features/auth/register/presentation/ui/widget/subtitles.dart';
import 'package:e_commerce_app/gen/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formkey = GlobalKey<FormState>();
  var firstnamecontroller = TextEditingController();
  var lastnamecontroller = TextEditingController();
  var namecontroller = TextEditingController();
  var passwordcontroller = TextEditingController();
  var emailcontroller = TextEditingController();
  var adresscontroller = TextEditingController();
  var citycontroller = TextEditingController();
  var countrycontroller = TextEditingController();

  @override
  void dispose() {
    namecontroller.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
    firstnamecontroller.dispose();
    lastnamecontroller.dispose();
    adresscontroller.dispose();
    citycontroller.dispose();
    countrycontroller.dispose();

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
                  RegisterBlocListen(),
                  20.verticalSpace,
                  Text(
                    LocaleKeys.registertitle.tr(),
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  40.verticalSpace,
                  Subtitles(subtitle: LocaleKeys.nametitle.tr()),
                  10.verticalSpace,
                  AppTextField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return LocaleKeys.namefield.tr();
                      }
                      return null;
                    },
                    controller: namecontroller,
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
                    controller: firstnamecontroller,
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
                    controller: lastnamecontroller,
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
                    controller: emailcontroller,
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
                    controller: passwordcontroller,
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
                    controller: adresscontroller,
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
                    controller: namecontroller,
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
                    controller: countrycontroller,
                    text: LocaleKeys.countryfield.tr(),
                    keyboardtype: TextInputType.name,
                  ),
                  20.verticalSpace,
                  AppContainer(
                    text: LocaleKeys.registertitle.tr(),
                    onTap: () {
                      if (formkey.currentState!.validate()) {
                        context.read<RegisterCubit>().registerState(
                          RegisterReqModel(
                            username: namecontroller.text,
                            firstName: firstnamecontroller.text,
                            lastName: lastnamecontroller.text,
                            email: emailcontroller.text,
                            password: passwordcontroller.text,
                            address: Address(
                              address: adresscontroller.text,
                              city: citycontroller.text,
                              country: countrycontroller.text,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                  15.verticalSpace,
                  AuthDivider(),
                  30.verticalSpace,
                  AuthContainer(
                    text: LocaleKeys.googlelogin.tr(),
                    onTap: () async {
                      await signInWithGoogle(context);
                    },
                    containcolor: Colors.white,
                    icon: 'assets/icons/google-icon-logo-svgrepo-com.svg',
                  ),
                  20.verticalSpace,
                  AuthContainer(
                    text: LocaleKeys.facelogin.tr(),
                    onTap: () async {
                      var user = await signInWithFacebook(context);
                      if (user != null) {
                        print(
                          'مرحباً بكِ، تم تسجيل الدخول بواسطة: ${user.email}',
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'فشل تسجيل الدخول بواسطة فيسبوك، حاول مرة أخرى',
                            ),
                            backgroundColor: AppColor.containercolor,
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
                        LocaleKeys.alreadytitle.tr(),
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      5.horizontalSpace,
                      InkWell(
                        onTap: () {
                          context.pushNamed(Routes.loginscreen);
                        },
                        child: Text(
                          LocaleKeys.logintitle.tr(),
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                    ],
                  ),
                  50.verticalSpace,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
