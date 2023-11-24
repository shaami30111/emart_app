import 'dart:ui';

import 'package:ai_art_gen/constants/color_constants.dart';
import 'package:ai_art_gen/models/image_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nb_utils/nb_utils.dart';

import '../Utils/common_functions.dart';

final shareImages = [
  ImageModel(
      imagePath: "assets/creation/facebook.png", description: "Facebook"),
  ImageModel(
      imagePath: "assets/creation/whatsapp.png", description: "WhatsApp"),
  ImageModel(imagePath: "assets/creation/twitter.png", description: "Twitter"),
  ImageModel(
      imagePath: "assets/creation/instagram.png", description: "Instagram"),
  ImageModel(imagePath: "assets/creation/more.png", description: "More"),
];

shareSheet(BuildContext context, String? imagePath) {
  showModalBottomSheet(
    context: context,
    constraints: BoxConstraints(
      maxHeight: 350.h,
    ),
    // showDragHandle: true,
    barrierColor: Colors.transparent,
    elevation: 0,
    isDismissible: true,
    backgroundColor: iconColor,
    builder: (context) => BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: StatefulBuilder(builder: (context, changeState) {
        return Container(
          width: double.maxFinite,
          height: 350.h,
          padding: EdgeInsets.only(
            top: 35.h,
            bottom: 35.h,
            left: 50.w,
            right: 50.w,
          ),
          decoration: ShapeDecoration(
            color: iconColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35.r),
                topRight: Radius.circular(35.r),
              ),
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
                height: 34.h,
              ),
              Text(
                'Share this artwork',
                style: TextStyle(
                  fontSize: 22.sp,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.54,
                ),
              ),
              const Spacer(),
              HorizontalList(
                itemCount: 5,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                spacing: 40.w,
                itemBuilder: (context, index) {
                  return buildWidget(index, imagePath);
                },
              )
            ],
          ),
        );
      }),
    ),
  );
}

buildWidget(int index, String? imagePath) {
  return Column(
    children: [
      GestureDetector(
        onTap: () async {
          switch (index) {
            case 0:
              {
                await startFileShareOnFacebook(imagePath ?? "");
                break;
              }
            case 1:
              {
                await startFileShareOnWhatsApp(imagePath ?? "");
                break;
              }
            case 2:
              {
                await startFileShareOnX(imagePath ?? "");
                break;
              }
            case 3:
              {
                await startFileShareOnInstagram(imagePath ?? "");
                break;
              }
            case 4:
              {
                await startFileShare(imagePath ?? "");
                break;
              }
            default:
              {
                if (kDebugMode) {
                  print("Default case");
                }
              }
          }
        },
        child: Container(
          width: 65.w,
          height: 65.h,
          decoration: ShapeDecoration(
            image: DecorationImage(
              image: Image.asset(
                shareImages[index].imagePath!,
              ).image,
              fit: BoxFit.contain,
            ),
            shape: const OvalBorder(),
          ),
        ),
      ),
      SizedBox(
        height: 15.h,
      ),
      Text(
        shareImages[index].description!,
        style: TextStyle(
          fontSize: 18.sp,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w300,
          letterSpacing: 0.80,
        ),
      ),
    ],
  );
}
