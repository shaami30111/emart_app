import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/color_constants.dart';

class NoInternetScreen extends StatefulWidget {
  const NoInternetScreen({super.key});

  @override
  State<NoInternetScreen> createState() => _NoInternetScreenState();
}

class _NoInternetScreenState extends State<NoInternetScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.only(
            bottom: 32.h,
            top: 45.h,
          ),
          width: 570.w,
          height: 635.h,
          decoration: ShapeDecoration(
            color: btnTextColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(63),
            ),
            shadows: const [
              BoxShadow(
                color: Color(0x29000000),
                blurRadius: 5,
                offset: Offset(6, 6),
                spreadRadius: 0,
              )
            ],
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: 120.w,
                  right: 120.w,
                ),
                child: Image.asset(
                  "assets/Splash/No_internet.png",
                  height: 275.h,
                ),
              ),
              SizedBox(
                height: 35.h,
              ),
              Text(
                'No Internet',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 31.sp,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  // height: 0.03,
                  letterSpacing: 2.10.sp,
                ),
              ),
              SizedBox(
                height: 25.h,
              ),
              Text(
                'Something went wrong with your connection, \nplease check and try again',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w300,
                  // height: 0.12,
                  letterSpacing: 1.12.sp,
                ),
              ),
              const Spacer(),
              Container(
                width: 350.w,
                height: 75.h,
                decoration: ShapeDecoration(
                  gradient: gradientColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                ),
                child: Center(
                  child: Text(
                    'Try Again',
                    style: TextStyle(
                      color: btnTextColor,
                      fontSize: 25.sp,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      // height: 0.07,
                      letterSpacing: 1.75.sp,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
