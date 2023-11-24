import 'dart:ui';

import 'package:ai_art_gen/reuableWidget/ad_container.dart';
import 'package:ai_art_gen/reuableWidget/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nb_utils/nb_utils.dart';

import '../Utils/common_functions.dart';
import '../constants/color_constants.dart';
import '../models/rating.dart';

rateUs(BuildContext context) {
  int i = 0;

  showModalBottomSheet(
    context: context,
    // isScrollControlled: true,
    constraints: BoxConstraints(
      maxHeight: 625.h,
    ),
    barrierColor: Colors.transparent,
    elevation: 0,
    isDismissible: true,
    backgroundColor: Colors.transparent,
    builder: (context) => BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: StatefulBuilder(builder: (context, changeState) {
        return Container(
          height: 625.h,
          padding: EdgeInsets.only(top: 18.h),
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: iconColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50.r),
              topRight: Radius.circular(50.r),
            ),
          ),
          child: Column(
            children: [
              Container(
                width: 115.w,
                height: 10.h,
                decoration: ShapeDecoration(
                  color: const Color(0xFF6D6C73),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                ),
              ),
              SizedBox(
                height: 40.h,
              ),
              const AddContainer(),
              SizedBox(
                height: 40.h,
              ),
              Text(
                'Enjoying the App?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.40,
                ),
              ),
              SizedBox(
                height: 12.h,
              ),
              Text(
                'How much do you like this app?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17.sp,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  letterSpacing: 1.19,
                ),
              ),
              // SizedBox(
              //   height: 45.h,
              // ),
              const Spacer(),
              HorizontalList(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: ratingModelList[i].image?.length??0,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      i = index + 1;
                      changeState(
                        () {},
                      );
                    },
                    child: Image.asset(
                      ratingModelList[i].image?[index]??"",
                      height: 55.h,
                      width: 55.w,
                    ),
                  );
                },
              ),
              const Spacer(),
              GradientButtonCustom(
                onTap: () {
                  if(i>3){
                    rateUsMethod(context);
                  }else{
                    Fluttertoast.showToast(
                      msg: "Thanks For Rating us",
                      backgroundColor: mainColor.withOpacity(0.8),
                    );
                  }
                  finish(context);
                },
                height: 65.h,
                width: 540.w,
                decoration: ShapeDecoration(
                  gradient: gradientColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(33.r),
                  ),
                ),
                btnText: const Text("Rate Us"),
              ),
              SizedBox(
                height: 20.h,
              ),
              GestureDetector(
                onTap: () {
                  // finish(context);
                  Navigator.pop(context);
                },
                child: SizedBox(
                  width: 200.w,
                  height: 45.h,
                  child: Center(
                    child: Text(
                      'Maybe later',
                      style: TextStyle(
                        color: textColorLight,
                        fontSize: 18.sp,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w300,
                        letterSpacing: 1.26,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
            ],
          ),
        );
      }),
    ),
  );
}
