import 'package:e_commerce_app/core/app_widgets/app_container.dart';
import 'package:e_commerce_app/core/app_widgets/app_text_field.dart';
import 'package:e_commerce_app/core/app_widgets/auth_container.dart';
import 'package:e_commerce_app/core/app_widgets/divider/auth_divider.dart';
import 'package:e_commerce_app/core/helper/extentions/extension.dart';
import 'package:e_commerce_app/core/routes/routes.dart';
import 'package:e_commerce_app/core/theme/app_colors.dart';
import 'package:e_commerce_app/features/screens/auth/register/data/api_data/model/register_req_model.dart';
import 'package:e_commerce_app/features/screens/auth/register/presentation/cubit/register_cubit.dart';
import 'package:e_commerce_app/features/screens/auth/register/presentation/ui/widget/register_bloc_listen.dart';
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
  var namecontroller = TextEditingController();
  var passwordcontroller = TextEditingController();
  var emailcontroller = TextEditingController();

  @override
  void dispose() {
    namecontroller.dispose();
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
                  RegisterBlocListen(),
                  20.verticalSpace,
                  Text(
                    LocaleKeys.registertitle.tr(),
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  40.verticalSpace,
                  Text(
                    LocaleKeys.nametitle.tr(),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  10.verticalSpace,
                  AppTextField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your full name';
                      }
                      return null;
                    },
                    controller: namecontroller,
                    text: LocaleKeys.namefield.tr(),
                    keyboardtype: TextInputType.name,
                  ),
                  10.verticalSpace,
                  Text(
                    LocaleKeys.emailtitle.tr(),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
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
                  Text(
                    LocaleKeys.passwordtitle.tr(),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
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
                  20.verticalSpace,
                  AppContainer(
                    text: LocaleKeys.registertitle.tr(),
                    onTap: () {
                      if (formkey.currentState!.validate()) {
                        context.read<RegisterCubit>().registerState(
                          RegisterReqModel(
                            userName: namecontroller.text,
                            email: emailcontroller.text,
                            password: passwordcontroller.text,
                          ),
                        );
                      }
                    },
                  ),
                  15.verticalSpace,
                  AuthDivider(),
                  30.verticalSpace,
                  AuthContainer(
                    text: LocaleKeys.googletitle.tr(),
                    onTap: () {},
                    containcolor: Colors.white,
                    icon: 'assets/icons/google-icon-logo-svgrepo-com.svg',
                  ),
                  20.verticalSpace,
                  AuthContainer(
                    text: LocaleKeys.facetitle.tr(),
                    onTap: () {},
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
