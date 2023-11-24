// ignore_for_file: must_be_immutable

import 'dart:math';

import 'package:ai_art_gen/Utils/common_functions.dart';
import 'package:ai_art_gen/constants/color_constants.dart';
import 'package:ai_art_gen/constants/text_constants.dart';
import 'package:ai_art_gen/ui_screens/favorite/favorite.dart';
import 'package:ai_art_gen/ui_screens/language/language_screen.dart';
import 'package:ai_art_gen/ui_screens/my_creation/my_creation.dart';
import 'package:ai_art_gen/ui_screens/premium/dark_premium_screen.dart';
import 'package:ai_art_gen/ui_screens/rate_us.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nb_utils/nb_utils.dart';

class MainDrawer extends StatefulWidget {
  GlobalKey<ScaffoldState> scaffoldKey;

  MainDrawer({
    Key? key,
    required this.scaffoldKey,
  }) : super(key: key);

  @override
  State<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  List<String> drawerItem = [
    "Theme",
    "Language",
    "My Creation",
    "Favorite",
    "More Apps",
    "Privacy Policy",
    "Rate Us",
    "Share",
  ];

  List<String> drawerImage = [
    "assets/drawer/Theme.png",
    "assets/drawer/language.png",
    "assets/drawer/image-.png",
    "assets/drawer/Love.png",
    "assets/drawer/More_apps.png",
    "assets/drawer/privacy.png",
    "assets/drawer/rating.png",
    "assets/drawer/share.png",
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: 519.w,
        // height: 1362.h,
        decoration: BoxDecoration(
          color: iconColor,
          border: Border.all(width: 1),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: 34.h,
                right: 28.w,
                left: 28.w,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          widget.scaffoldKey.currentState!.closeDrawer();
                        },
                        child: Container(
                          padding: EdgeInsets.all(3.w),
                          decoration: const ShapeDecoration(
                            color: Color(0xFF12111D),
                            shape: OvalBorder(),
                          ),
                          child: Icon(
                            Icons.close,
                            size: 35.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 35.h,
                  ),
                  Container(
                    width: 462.w,
                    height: 186.h,
                    decoration: ShapeDecoration(
                      color: containerSecondary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.r),
                      ),
                    ),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(25.r),
                            child: Image.asset("assets/topDot.png"),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(25.r),
                            child: Image.asset("assets/bottomDot.png"),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            margin: EdgeInsets.only(
                              right: 25.w,
                              bottom: 30.h,
                            ),
                            width: 120.w,
                            height: 122.h,
                            decoration: ShapeDecoration(
                              color: mainColor,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(width: 2.w, color: mainColor),
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.r),
                              child: Image.asset(
                                "assets/drawer/drawer.png",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            margin: EdgeInsets.only(
                              top: 22.h,
                              left: 23.w,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'AI Art Generator',
                                  style: TextStyle(
                                    color: const Color(0xff101739),
                                    fontSize: 25.sp,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 0.39,
                                  ),
                                ),
                                Text(
                                  'Unlock all templates for free',
                                  style: TextStyle(
                                    color: textColorDark,
                                    fontSize: 13.sp,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 0.39,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                              const PremiumScreen().launch(context);
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                bottom: 26.h,
                                left: 23.w,
                              ),
                              padding: EdgeInsets.only(
                                left: 18.w,
                                right: 18.w,
                                top: 10.h,
                                bottom: 10.h,
                              ),
                              decoration: ShapeDecoration(
                                gradient: const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color(0xFF744BC8),
                                    Color(0xFF6C4ECA),
                                    Color(0xFF6351CC),
                                    // Color(0xFF5A54CE),
                                    // Color(0xFF4B59D2),
                                    Color.fromARGB(255, 53, 86, 231),
                                    Color(0xFF066FE2),
                                    Color(0xFF066FE2),
                                  ],
                                  transform: GradientRotation(
                                    (pi / 3),
                                  ),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                shadows: [
                                  BoxShadow(
                                    color: const Color(0x29000000),
                                    blurRadius: 3.r,
                                    offset: const Offset(0, 3),
                                    spreadRadius: 0,
                                  )
                                ],
                              ),
                              child: Text(
                                'Purchase Now',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Container(
                    width: 462.w,
                    padding: EdgeInsets.only(
                      top: 5.h,
                      left: 23.w,
                      right: 27.w,
                      bottom: 20.h,
                    ),
                    decoration: ShapeDecoration(
                      color: iconColorSecondary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.r),
                      ),
                    ),
                    child: Column(
                      children: [
                        drawerTile(
                          0,
                          () {},
                        ),
                        drawerTile(
                          1,
                          () {
                            Navigator.of(context).pop();
                            LanguageScreen(
                              isSetting: true,
                            ).launch(context);
                          },
                        ),
                        drawerTile(
                          2,
                          () async {
                            var version = await checkAndroidVersion();
                            if (version >= 33) {
                              bool permission = await requestPermissions13();
                              if (permission) {
                                // ignore: use_build_context_synchronously
                                Navigator.of(context).pop();
                                // ignore: use_build_context_synchronously
                                const MyCreation().launch(context);
                              }
                            } else {
                              bool permission = await requestPermissions();
                              if (permission) {
                                // ignore: use_build_context_synchronously
                                Navigator.of(context).pop();
                                // ignore: use_build_context_synchronously
                                const MyCreation().launch(context);
                              }
                            }
                          },
                        ),
                        drawerTile(
                          3,
                          () {
                            Navigator.of(context).pop();
                            const Favorite().launch(context);
                          },
                        ),
                        drawerTile(
                          4,
                          () {
                            Navigator.of(context).pop();
                            launchUrlCustom(moreAppsUrl);
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  Container(
                    width: 462.w,
                    padding: EdgeInsets.only(
                      top: 5.h,
                      left: 23.w,
                      right: 27.w,
                      bottom: 20.h,
                    ),
                    decoration: ShapeDecoration(
                      color: iconColorSecondary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.r),
                      ),
                    ),
                    child: Column(
                      children: [
                        drawerTile(
                          5,
                          () {
                            Navigator.of(context).pop();
                            launchUrlCustom(privacyUrl);
                          },
                        ),
                        drawerTile(
                          6,
                          () {
                            Navigator.of(context).pop();
                            rateUs(context);
                          },
                        ),
                        drawerTile(
                          7,
                          () {
                            Navigator.of(context).pop();
                            shareApp(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Container(
              width: 519.w,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 0.20.w,
                    strokeAlign: BorderSide.strokeAlignCenter,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                top: 28.h,
                bottom: 17.h,
              ),
              child: Text(
                'Version 1.1',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.6509804129600525),
                  fontSize: 16.sp,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.48,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  drawerTile(int index, VoidCallback onTap) {
    return Column(
      children: [
        ListTile(
          onTap: onTap,
          visualDensity: const VisualDensity(vertical: -4),
          horizontalTitleGap: -5.w,
          splashColor: transparentColor,
          contentPadding: EdgeInsets.only(
            left: 1.w,
            bottom: 1.w,
            // top: -1.h,
          ),
          leading: Image.asset(
            drawerImage[index],
            width: 25.w,
            height: 25.h,
          ),
          title: Row(
            children: [
              Text(
                drawerItem[index],
                style: TextStyle(
                  fontSize: 20.sp,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.60,
                ),
              ),
              drawerItem[index] == 'More Apps'
                  ? Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 7.w, vertical: 8.h),
                      padding:
                          EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: const Color(0xffFFC107),
                          borderRadius: BorderRadius.circular(5.w)),
                      child: Text(
                        'AD',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color(0xFF00002A),
                          fontSize: 15.sp,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          // height: 0.19,
                          letterSpacing: 0.45,
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            // right: 27.w,
            left: 5.w,
            top: 5.h,
            bottom: 10.h,
          ),
          child: Image.asset(
            "assets/drawer/seperator.png",
          ),
        ),
      ],
    );
  }
}
