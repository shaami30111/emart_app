import 'package:ai_art_gen/constants/color_constants.dart';
import 'package:ai_art_gen/reuableWidget/button.dart';
import 'package:ai_art_gen/ui_screens/home/home_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nb_utils/nb_utils.dart';

import '../Utils/common_functions.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(
            top: 30.h,
            bottom: 30.h,
          ),
          child: Center(
            child: Column(
              children: [
                Text(
                  'Welcome to \nAI Art Generator',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 41.sp,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.23,
                  ),
                ),
                Text(
                  'Turn your WORDS into Exquisite art',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: textColorMain,
                    fontSize: 18.sp,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                Stack(
                  children: [
                    Container(
                      // margin: EdgeInsets.only(
                      //   top: 40.h,
                      //   bottom: 40.h,
                      // ),
                      width: 834.w,
                      height: 930.h,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 460.w,
                            top: 456.h,
                            child: Container(
                              width: 357.w,
                              height: 467.h,
                              decoration: ShapeDecoration(
                                image: DecorationImage(
                                  image: Image.asset("assets/bottomRight.png")
                                      .image,
                                  fit: BoxFit.fill,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(50.r),
                                    bottomRight: Radius.circular(50.r),
                                  ),
                                ),
                                // shadows: [
                                //   BoxShadow(
                                //     color: textColorMain,
                                //     blurRadius: 3.r,
                                //     offset: const Offset(1, 1),
                                //     spreadRadius: 0,
                                //   )
                                // ],
                              ),
                            ),
                          ),
                          Positioned(
                            left: 0.w,
                            top: 0.h,
                            child: Container(
                              width: 834.w,
                              height: 514.h,
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: 0.w,
                                    top: 0.h,
                                    child: Container(
                                      width: 393.w,
                                      height: 514.h,
                                      decoration: ShapeDecoration(
                                        image: DecorationImage(
                                          image:
                                              Image.asset("assets/topLeft.png")
                                                  .image,
                                          fit: BoxFit.fill,
                                        ),
                                        shape: const RoundedRectangleBorder(
                                            //          borderRadius: BorderRadius.only(
                                            //   topLeft: Radius.circular(50.r),
                                            //   bottomLeft: Radius.circular(50.r),
                                            // ),
                                            ),
                                        // shadows: [
                                        //   BoxShadow(
                                        //     color: textColorMain,
                                        //     blurRadius: 3.r,
                                        //     offset: const Offset(1, 1),
                                        //     spreadRadius: 0,
                                        //   )
                                        // ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 460.w,
                                    top: 0.h,
                                    child: Container(
                                      width: 374.w,
                                      height: 408.h,
                                      decoration: ShapeDecoration(
                                        image: DecorationImage(
                                          image:
                                              Image.asset("assets/topRight.png")
                                                  .image,
                                          fit: BoxFit.fill,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(50.r),
                                            bottomRight: Radius.circular(50.r),
                                          ),
                                        ),
                                        // shadows: [
                                        //   BoxShadow(
                                        //     color: textColorMain,
                                        //     blurRadius: 3.r,
                                        //     offset: const Offset(1, 1),
                                        //     spreadRadius: 0,
                                        //   )
                                        // ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            left: 9.w,
                            top: 539.h,
                            child: Container(
                              width: 352.w,
                              height: 384.h,
                              decoration: ShapeDecoration(
                                image: DecorationImage(
                                  image: Image.asset("assets/bottomLeft.png")
                                      .image,
                                  fit: BoxFit.fill,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(50.r),
                                    bottomRight: Radius.circular(50.r),
                                  ),
                                ),
                                // shadows: [
                                //   BoxShadow(
                                //     color: textColorMain,
                                //     blurRadius: 3.r,
                                //     offset: const Offset(1, 1),
                                //     spreadRadius: 0.r,
                                //   )
                                // ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 130.h,
                      left: 100.w,
                      child: Container(
                        // width: 505.w,
                        // height: 620.h,
                        padding: EdgeInsets.only(
                          top: 7.h,
                          left: 7.w,
                        ),
                        alignment: Alignment.center,
                        decoration: ShapeDecoration(
                          color: textColorMain,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                          shadows: [
                            BoxShadow(
                              color: textColorMain,
                              blurRadius: 5.r,
                              offset: const Offset(2.5, 2.5),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15.r),
                          child: Image.asset(
                            "assets/center.png",
                            width: 490.w,
                            height: 605.h,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 105.h,
                      left: 40.w,
                      child: Container(
                        padding: EdgeInsets.only(
                          top: 10.h,
                          bottom: 10.h,
                          right: 20.w,
                          left: 20.w,
                        ),
                        decoration: ShapeDecoration(
                          color: Colors.white.withOpacity(0.6509804129600525),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                        ),
                        child: Text(
                          'Age of Innocence',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF101739),
                            fontSize: 18.sp,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.54,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 170.h,
                      right: 15.w,
                      child: Container(
                        padding: EdgeInsets.only(
                          top: 10.h,
                          bottom: 10.h,
                          right: 20.w,
                          left: 20.w,
                        ),
                        decoration: ShapeDecoration(
                          color: Colors.white.withOpacity(0.6509804129600525),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                        ),
                        child: Text(
                          'Strength in Expression',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF101739),
                            fontSize: 18.sp,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.54,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 290.h,
                      left: 50.w,
                      child: Container(
                        padding: EdgeInsets.only(
                          top: 10.h,
                          bottom: 10.h,
                          right: 20.w,
                          left: 20.w,
                        ),
                        decoration: ShapeDecoration(
                          color: Colors.white.withOpacity(0.6509804129600525),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                        ),
                        child: Text(
                          'Beautiful choas',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF101739),
                            fontSize: 18.sp,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.54,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 250.h,
                      right: 20.w,
                      child: Container(
                        padding: EdgeInsets.only(
                          top: 10.h,
                          bottom: 10.h,
                          right: 30.w,
                          left: 30.w,
                        ),
                        decoration: ShapeDecoration(
                          color: Colors.white.withOpacity(0.6509804129600525),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                        ),
                        child: Text(
                          'Young Girl',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF101739),
                            fontSize: 18.sp,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.54,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                GradientButtonCustom(
                  onTap: () async {
                    const HomeScreen().launch(context, isNewTask: true);
                    SharedPreferences pref =
                        await SharedPreferences.getInstance();
                    pref.setBool("isFirstTime", true);
                  },
                  btnText: Text(
                    'Get Started',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25.sp,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.75,
                    ),
                  ),
                  width: 513.w,
                  height: 65.h,
                  decoration: ShapeDecoration(
                    gradient: gradientColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(33.r),
                    ),
                  ),
                ),
                // SizedBox(
                //   height: 35.h,
                // ),
                const Spacer(),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'By pressing get started you agree our \n',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextSpan(
                          text: 'Terms of Services',
                          style: TextStyle(
                            color: complColor,
                            fontSize: 18.sp,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            decoration: TextDecoration.underline,
                            decorationColor: complColor,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              openTermOfUseUrl(context);
                            }),
                      TextSpan(
                        text: ' ',
                        style: TextStyle(
                          color: const Color(0xFF101739),
                          fontSize: 18.sp,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextSpan(
                        text: 'and',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextSpan(
                        text: ' ',
                        style: TextStyle(
                          color: const Color(0xFF101739),
                          fontSize: 18.sp,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextSpan(
                        text: 'Privacy Policy',
                        style: TextStyle(
                          color: complColor,
                          fontSize: 18.sp,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          decoration: TextDecoration.underline,
                          decorationColor: complColor,
                        ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              openPrivacyUrl(context);
                            }
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
