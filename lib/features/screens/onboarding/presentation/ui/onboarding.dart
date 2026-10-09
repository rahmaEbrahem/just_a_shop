import 'package:e_commerce_app/core/app_widgets/app_container.dart';
import 'package:e_commerce_app/core/helper/extentions/extension.dart';
import 'package:e_commerce_app/core/routes/routes.dart';
import 'package:e_commerce_app/core/theme/app_colors.dart';
import 'package:e_commerce_app/core/theme/cubit/theme_cubit.dart';
import 'package:e_commerce_app/features/screens/onboarding/presentation/ui/widgets/indicator_container.dart';
import 'package:e_commerce_app/features/screens/onboarding/presentation/ui/widgets/onboarding_item.dart';
import 'package:e_commerce_app/gen/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final PageController pageController = PageController(initialPage: 1);
  Timer? onboardingTimer;
  int currentpage = 0;

  void startAutoScroll() {
    onboardingTimer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (currentpage < 2) {
        currentpage++;
        pageController.animateToPage(
          currentpage,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      } else {
        currentpage = 0;
        pageController.jumpToPage(currentpage);
      }
    });
  }

  @override
  void dispose() {
    onboardingTimer?.cancel();
    pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    startAutoScroll();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: 600.h,
              child: PageView(
                controller: pageController,
                onPageChanged: (index) {
                  setState(() {
                    currentpage = index;
                  });
                },
                children: [
                  OnboardingItem(
                    image: 'assets/images/onbording.png',
                    title: LocaleKeys.discovertitle.tr(),
                    decription: LocaleKeys.discoverdesc.tr(),
                  ),
                  OnboardingItem(
                    image: 'assets/images/onbording1.png',
                    title: LocaleKeys.choosetitle.tr(),
                    decription: LocaleKeys.choosedesc.tr(),
                  ),
                  OnboardingItem(
                    image: 'assets/images/onbordig2.png',
                    title: LocaleKeys.completetilte.tr(),
                    decription: LocaleKeys.completedesc.tr(),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IndicatorContainer(isSelected: currentpage == 0),
                10.horizontalSpace,
                IndicatorContainer(isSelected: currentpage == 1),
                10.horizontalSpace,
                IndicatorContainer(isSelected: currentpage == 2),
              ],
            ),
            40.verticalSpace,
            AppContainer(
              text: LocaleKeys.getbutton.tr(),
              onTap: () {
                context.pushReplacemetNamed(Routes.registerscreen);
              },
            ),
          ],
        ),
      ),
    );
  }
}
