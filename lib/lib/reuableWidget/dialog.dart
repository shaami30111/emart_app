import 'dart:ui';

import 'package:ai_art_gen/Utils/common_functions.dart';
import 'package:ai_art_gen/provider/selection_provider.dart';
import 'package:ai_art_gen/reuableWidget/ad_container.dart';
import 'package:ai_art_gen/reuableWidget/history_sheet.dart';
import 'package:ai_art_gen/reuableWidget/model_sheet.dart';
import 'package:ai_art_gen/reuableWidget/result_sheet.dart';
import 'package:ai_art_gen/reuableWidget/style_sheet.dart';
import 'package:ai_art_gen/ui_screens/home/advanced_settings.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

import '../constants/color_constants.dart';
import '../database/database.dart';
import '../main.dart';
import '../models/aspectratio_model.dart';
import '../models/image_model.dart';
import '../models/inspiration_base_response.dart';
import 'button.dart';
import 'gradient_button.dart';

showExitConfirmation(BuildContext context) async {
  final result = await showModalBottomSheet(
    context: context,
    // isScrollControlled: true,
    constraints: BoxConstraints(
      maxHeight: 500.h,
    ),
    barrierColor: Colors.transparent,
    elevation: 0,
    isDismissible: false,
    backgroundColor: Colors.transparent,
    builder: (context) => BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: StatefulBuilder(builder: (context, changeState) {
        return Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 500.h,
                // color: Colors.transparent,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 550.h,
                padding: EdgeInsets.only(
                  top: 30.h,
                  bottom: 40.h,
                  left: 30.w,
                  right: 30.w,
                ),
                width: double.maxFinite,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50.r),
                    topRight: Radius.circular(50.r),
                  ),
                  color: btnTextColor,
                ),
                child: Column(
                  children: [
                    Container(
                      width: 115.w,
                      height: 10.h,
                      decoration: ShapeDecoration(
                        color: const Color(0xFF808080),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3.r),
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
                      'Are you sure, you want to exit app?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.40,
                      ),
                    ),
                    SizedBox(
                      height: 55.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GradientButton(
                          onTap: () {
                            Navigator.of(context).pop(false);
                          },
                          btntext: Text(
                            'Cancel',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 22.sp,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          width: 199.w,
                          height: 65.h,
                          icon: const SizedBox.shrink(),
                          decoration: ShapeDecoration(
                            color: const Color(0xFF12111D),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  width: 0.50.w, color: Colors.white),
                              borderRadius: BorderRadius.circular(33),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 30.w,
                        ),
                        GradientButton(
                          onTap: () {
                            SystemNavigator.pop();
                          },
                          btntext: Text(
                            'Exit',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 22.sp,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          width: 199.w,
                          height: 65.h,
                          icon: const SizedBox.shrink(),
                          decoration: ShapeDecoration(
                            gradient: gradientColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(33.r),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    ),
  );

  if (result == true) {
    // ignore: use_build_context_synchronously
    Navigator.of(context).pop(); // Close the app
  }
}

dialogModal(
  BuildContext context,
  bool withBtn,
  String dialog, [
  VoidCallback? onTapF,
  VoidCallback? onTapS,
  Widget? btnFirst,
  Widget? btnSecond,
  ShapeDecoration? decorationF,
  ShapeDecoration? decorationS,
  Widget? media,
]) {
  return showDialog(
    context: context,
    builder: (context) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(63.r)),
          child: Container(
            // width: 570.w,
            // height: 604.h,
            padding: EdgeInsets.only(
              top: 70.h,
              bottom: 70.h,
              left: 60.w,
              right: 60.w,
            ),
            decoration: ShapeDecoration(
              color: btnTextColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(63.r),
              ),
              shadows: [
                BoxShadow(
                  color: const Color(0x29000000),
                  blurRadius: 5.r,
                  offset: const Offset(6, 6),
                  spreadRadius: 0,
                )
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                media ?? const SizedBox.shrink(),
                SizedBox(
                  height: 30.h,
                ),
                Text(
                  dialog,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 23.sp,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.61,
                  ),
                ),
                SizedBox(
                  height: 60.h,
                ),
                withBtn
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GradientButton(
                            onTap: onTapF,
                            btntext: btnFirst,
                            width: 180.w,
                            height: 55.h,
                            icon: const SizedBox.shrink(),
                            decoration: decorationF,
                          ),
                          SizedBox(
                            width: 60.w,
                          ),
                          GradientButton(
                            icon: const SizedBox.shrink(),
                            onTap: onTapS,
                            height: 55.h,
                            width: 180.w,
                            decoration: decorationS,
                            btntext: btnSecond,
                          ),
                        ],
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
        ),
      );
    },
  );
}

discardDialog(
  BuildContext context,
) {
  return showDialog(
    context: context,
    builder: (context) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(63.r)),
          child: Container(
            // width: 570.w,
            // height: 604.h,
            padding: EdgeInsets.only(
              top: 90.h,
              bottom: 75.h,
              left: 65.w,
              right: 65.w,
            ),
            decoration: ShapeDecoration(
              color: iconColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(63.r),
              ),
              shadows: [
                BoxShadow(
                  color: const Color(0x29000000),
                  blurRadius: 5.r,
                  offset: const Offset(6, 6),
                  spreadRadius: 0,
                )
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Discard Changes?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 23.sp,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.61,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  'All changes will be lost.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1.12,
                  ),
                ),
                SizedBox(
                  height: 65.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GradientButton(
                      onTap: () {
                        Provider.of<SelectionProvider>(context, listen: false)
                            .initialize();
                        finish(context);
                        finish(context);
                      },
                      btntext: Text(
                        'Discard',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          letterSpacing: 1.40,
                        ),
                      ),
                      width: 200.w,
                      height: 65.h,
                      icon: const SizedBox.shrink(),
                      decoration: ShapeDecoration(
                        color: const Color(0xFF1C1C29),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(width: 2.w, color: Colors.white),
                          borderRadius: BorderRadius.circular(33.r),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 30.w,
                    ),
                    GradientButton(
                      icon: const SizedBox.shrink(),
                      onTap: () {
                        Navigator.pop(context);
                      },
                      height: 65.h,
                      width: 200.w,
                      decoration: ShapeDecoration(
                        gradient: gradientColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(33.r),
                        ),
                      ),
                      btntext: Text(
                        'Cancel',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          letterSpacing: 1.40,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}

oopsDialog(
  BuildContext context,
) {
  return showDialog(
    context: context,
    builder: (context) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(63.r)),
          child: Container(
            // width: 570.w,
            // height: 604.h,
            padding: EdgeInsets.only(
              top: 30.h,
              bottom: 45.h,
              left: 90.w,
              right: 90.w,
            ),
            decoration: ShapeDecoration(
              color: iconColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(63.r),
              ),
              shadows: [
                BoxShadow(
                  color: const Color(0x29000000),
                  blurRadius: 5.r,
                  offset: const Offset(6, 6),
                  spreadRadius: 0,
                )
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  "assets/ooppss.png",
                  width: 280.w,
                  height: 210.h,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  "Oops?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25.sp,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.61,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  'Something went wrong',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1.12,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

generateDialog(BuildContext context, Widget media) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(63.r)),
          child: Stack(
            children: [
              Consumer<SelectionProvider>(
                builder: (context, value, child) {
                  return Container(
                    // width: 570.w,
                    // height: 604.h,
                    padding: EdgeInsets.only(
                      top: 70.h,
                      bottom: 70.h,
                      left: 60.w,
                      right: 60.w,
                    ),
                    decoration: ShapeDecoration(
                      color: iconColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(63.r),
                      ),
                      shadows: [
                        BoxShadow(
                          color: const Color(0x29000000),
                          blurRadius: 5.r,
                          offset: const Offset(6, 6),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        media,
                        SizedBox(
                          height: 30.h,
                        ),
                        Text(
                          value.dialog,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 23.sp,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1.61,
                          ),
                        ),
                        SizedBox(
                          height: 50.h,
                        ),
                      ],
                    ),
                  );
                },
              ),
              Positioned(
                top: 24.h,
                right: 22.w,
                child: GestureDetector(
                  onTap: () {
                    var pro =
                        Provider.of<SelectionProvider>(context, listen: false);

                    pro.cancelApiRequest();
                    if (pro.cancelApi.isCancelled) {
                      if (kDebugMode) {
                        print("API Request Cancelled By USER!!!!!!!!!!");
                      }
                    }
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.all(5.sp),
                    decoration: const BoxDecoration(
                      color: Color(0xFF32313B),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.close,
                      size: 30.sp,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

tryDialog(
  BuildContext context,
  VoidCallback onTapF,
  InspirationBaseResponse inspirationBaseResponse,
  TextEditingController promptTextController,
) {
  return showDialog(
    context: context,
    builder: (context) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Dialog(
          insetPadding: EdgeInsets.only(
            left: 80.w,
            right: 80.w,
            top: 285.h,
            bottom: 390.h,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40.r),
          ),
          child: Container(
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40.r),
              ),
            ),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(40.r),
                  child: CachedNetworkImage(
                    width: 560.w,
                    height: 780.h,
                    fit: BoxFit.cover,
                    imageUrl: inspirationBaseResponse.path ?? "",
                    placeholder: (context, url) => SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: Container(
                        decoration: BoxDecoration(
                          color: iconColor,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        padding: EdgeInsets.only(
                          top: 10.h,
                          right: 10.w,
                          left: 10.w,
                          bottom: 10.h,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            LottieBuilder.asset(
                              "assets/icons/Processing_Image.json",
                              width: 85.w,
                              height: 85.h,
                            ),
                          ],
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
                Positioned(
                  top: 24.h,
                  right: 22.w,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: EdgeInsets.all(5.sp),
                      decoration: const BoxDecoration(
                        color: Color(0xFFF5F5F5),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.close,
                        size: 30.sp,
                        color: iconColor,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    promptTextController.text =
                        inspirationBaseResponse.command ?? "";
                    finish(context);
                  },
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                        padding: EdgeInsets.only(
                          top: 26.h,
                          left: 55.w,
                          right: 55.w,
                          bottom: 28.h,
                        ),
                        decoration: ShapeDecoration(
                          color: Colors.black.withOpacity(0.35),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(40.r),
                              bottomRight: Radius.circular(40.r),
                            ),
                          ),
                          shadows: [
                            BoxShadow(
                              color: const Color(0x29000000),
                              blurRadius: 5.r,
                              offset: const Offset(6, 6),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              inspirationBaseResponse.command ?? "",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                top: 25.h,
                              ),
                              padding: EdgeInsets.only(
                                top: 10.h,
                                bottom: 10.h,
                                left: 120.w,
                                right: 120.w,
                              ),
                              decoration: ShapeDecoration(
                                gradient: gradientColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(33.r),
                                ),
                              ),
                              child: Text(
                                'Try this',
                                style: TextStyle(
                                  fontSize: 25.sp,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            )
                          ],
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

styleSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    // constraints: BoxConstraints(
    //   maxHeight: 600.h,
    // ),
    barrierColor: Colors.transparent,
    elevation: 0,
    isDismissible: false,

    backgroundColor: Colors.transparent,
    builder: (context) => BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: StatefulBuilder(builder: (context, changeState) {
        return Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                // height: 600.h,
                // color: Colors.transparent,
              ),
            ),
            const Align(
              alignment: Alignment.bottomCenter,
              child: StyleSheet(),
            ),
          ],
        );
      }),
    ),
  );
}

historySheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    // constraints: BoxConstraints(
    //   maxHeight: 600.h,
    // ),
    barrierColor: Colors.transparent,
    elevation: 0,
    isDismissible: false,

    backgroundColor: Colors.transparent,
    builder: (context) => BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: StatefulBuilder(builder: (context, changeState) {
        return Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                // height: 600.h,
                // color: Colors.transparent,
              ),
            ),
            const Align(
              alignment: Alignment.bottomCenter,
              child: HistorySheet(),
            ),
          ],
        );
      }),
    ),
  );
}

modelSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    // constraints: BoxConstraints(
    //   maxHeight: 600.h,
    // ),
    barrierColor: Colors.transparent,
    elevation: 0,
    isDismissible: false,

    backgroundColor: Colors.transparent,
    builder: (context) => BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: StatefulBuilder(builder: (context, changeState) {
        return Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                // height: 600.h,
                // color: Colors.transparent,
              ),
            ),
            const Align(
              alignment: Alignment.bottomCenter,
              child: ModelSheet(),
            ),
          ],
        );
      }),
    ),
  );
}

ratioSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    // isScrollControlled: true,
    constraints: BoxConstraints(
      maxHeight: MediaQuery.sizeOf(context).height * 0.27,
    ),
    barrierColor: Colors.transparent,
    elevation: 0,
    isDismissible: true,
    backgroundColor: Colors.transparent,
    builder: (context) => BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: StatefulBuilder(
        builder: (context, changeState) {
          return Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.27,
                  // color: Colors.transparent,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Consumer<SelectionProvider>(
                  builder: (context, value, child) {
                    return Container(
                      padding: EdgeInsets.only(
                        top: 30.h,
                        bottom: 25.h,
                      ),
                      // width: double.maxFinite,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50.r),
                          topRight: Radius.circular(50.r),
                        ),
                        color: btnTextColor,
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: 115.w,
                            height: 10.h,
                            decoration: ShapeDecoration(
                              color: const Color(0xFF808080),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(3.r),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 40.h,
                          ),
                          Text(
                            'Aspect Ratio',
                            style: TextStyle(
                              fontSize: 23.sp,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.61,
                            ),
                          ),
                          SizedBox(
                            height: 25.h,
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(
                                left: 25.w,
                                right: 25.w,
                                top: 30.h,
                              ),
                              height: MediaQuery.sizeOf(context).height * .27,
                              child: GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 5,
                                  mainAxisExtent: 70.h,
                                  mainAxisSpacing: 10.h,
                                  crossAxisSpacing: 10.w,
                                ),
                                itemCount: ratioBox.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      value.changeSelectedRatio(index);
                                      value.changeSelectedRatioMap(
                                          ratioBox[index]["width_value"],
                                          ratioBox[index]["height_value"]);
                                    },
                                    child: Container(
                                      width: 120.w,
                                      height: 60.h,
                                      // padding: EdgeInsets.only(
                                      //   top: 15.h,
                                      //   bottom: 15.h,
                                      //   left: 30.w,
                                      //   right: 29.w,
                                      // ),
                                      decoration: ShapeDecoration(
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                              width:
                                                  value.selectedRatio == index
                                                      ? 2.w
                                                      : 0.20.w,
                                              color: value.selectedRatio ==
                                                      index
                                                  ? mainColor
                                                  : const Color(0xFFCDCDCE)),
                                          borderRadius:
                                              BorderRadius.circular(15.r),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: ratioBox[index]["width"],
                                            height: ratioBox[index]["height"],
                                            decoration: ShapeDecoration(
                                              color:
                                                  value.selectedRatio == index
                                                      ? mainColor
                                                      : const Color(0xFFCDCDCE),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          3.r)),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 12.w,
                                          ),
                                          Text(
                                            ratioBox[index]["ratio"],
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 18.sp,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    ),
  );
}

ratioMSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    // isScrollControlled: true,
    constraints: BoxConstraints(
      maxHeight: MediaQuery.sizeOf(context).height * 0.27,
    ),
    barrierColor: Colors.transparent,
    elevation: 0,
    isDismissible: true,
    backgroundColor: Colors.transparent,
    builder: (context) => BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: StatefulBuilder(
        builder: (context, changeState) {
          return Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.27,
                  // color: Colors.transparent,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Consumer<SelectionProvider>(
                  builder: (context, value, child) {
                    return Container(
                      padding: EdgeInsets.only(
                        top: 30.h,
                        bottom: 25.h,
                      ),
                      // width: double.maxFinite,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50.r),
                          topRight: Radius.circular(50.r),
                        ),
                        color: btnTextColor,
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: 115.w,
                            height: 10.h,
                            decoration: ShapeDecoration(
                              color: const Color(0xFF808080),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(3.r),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 40.h,
                          ),
                          Text(
                            'Aspect Ratio',
                            style: TextStyle(
                              fontSize: 23.sp,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1.61,
                            ),
                          ),
                          SizedBox(
                            height: 25.h,
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(
                                left: 25.w,
                                right: 25.w,
                                top: 30.h,
                              ),
                              height: MediaQuery.sizeOf(context).height * .27,
                              child: GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 5,
                                  mainAxisExtent: 70.h,
                                  mainAxisSpacing: 10.h,
                                  crossAxisSpacing: 10.w,
                                ),
                                itemCount: ratioBox.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      value.changeSelectedRatio(index);
                                      value.changeSelectedRatioMap(
                                          ratioBox[index]["width_value"],
                                          ratioBox[index]["height_value"]);
                                    },
                                    child: Container(
                                      width: 120.w,
                                      height: 60.h,
                                      decoration: ShapeDecoration(
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                              width:
                                                  value.selectedRatio == index
                                                      ? 2.w
                                                      : 0.20.w,
                                              color: value.selectedRatio ==
                                                      index
                                                  ? mainColor
                                                  : const Color(0xFFCDCDCE)),
                                          borderRadius:
                                              BorderRadius.circular(15.r),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: ratioBox[index]["width"],
                                            height: ratioBox[index]["height"],
                                            decoration: ShapeDecoration(
                                              color:
                                                  value.selectedRatio == index
                                                      ? mainColor
                                                      : const Color(0xFFCDCDCE),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          3.r)),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 12.w,
                                          ),
                                          Text(
                                            ratioBox[index]["ratio"],
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 18.sp,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    ),
  );
}

advancedSettingSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    barrierColor: Colors.transparent,
    elevation: 0,
    isDismissible: false,
    backgroundColor: Colors.transparent,
    builder: (context) => BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: StatefulBuilder(builder: (context, changeState) {
        return Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                // height: 600.h,
                // color: Colors.transparent,
              ),
            ),
            const Align(
              alignment: Alignment.bottomCenter,
              child: AdvancedSettings(),
            ),
          ],
        );
      }),
    ),
  );
}

resultSheet(BuildContext context, String prompt) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    // constraints: BoxConstraints(
    //   maxHeight: 600.h,
    // ),
    barrierColor: Colors.transparent,
    elevation: 0,

    isDismissible: false,
    backgroundColor: Colors.transparent,
    builder: (context) => BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: StatefulBuilder(builder: (context, changeState) {
        return Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                // height: 600.h,
                // color: Colors.transparent,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ResultSheet(prompt: prompt),
            ),
          ],
        );
      }),
    ),
  );
}

generateVariantSheet(BuildContext context, String prompt) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    constraints: BoxConstraints(
      maxHeight: MediaQuery.sizeOf(context).height * 0.35,
    ),
    barrierColor: Colors.transparent,
    elevation: 0,
    isDismissible: false,
    backgroundColor: Colors.transparent,
    builder: (context) => BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: StatefulBuilder(builder: (context, changeState) {
        return Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                  color: iconColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(35.r),
                    topRight: Radius.circular(35.r),
                  ),
                ),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.sizeOf(context).height * 0.35,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                children: [
                  SizedBox(
                    height: 30.h,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.w),
                    width: 115.w,
                    height: 10.h,
                    decoration: ShapeDecoration(
                      color: const Color(0xFF808080),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3.r),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 70.h,
                  ),
                  Text(
                    prompt,
                    style: TextStyle(
                      fontSize: 23.sp,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.61,
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Text(
                    'Create more AI variants. The creations are \nendless.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 21.sp,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  const Spacer(),
                  GradientButtonCustom(
                    onTap: () {},
                    height: 75.h,
                    width: MediaQuery.sizeOf(context).width * 0.7,
                    decoration: ShapeDecoration(
                      gradient: gradientColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(33.r),
                      ),
                    ),
                    btnText: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/icons/video.png",
                          width: 26.38.w,
                          height: 29.98.h,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Generate',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0.60,
                              ),
                            ),
                            Text(
                              'Watch Ad',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w300,
                                letterSpacing: 0.45,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  smallButton(
                    onTap: () {},
                    icon: Image.asset(
                      "assets/icons/progen.png",
                      height: 25.h,
                      width: 25.w,
                    ),
                    width: MediaQuery.sizeOf(context).width * 0.7,
                    btntext: Text(
                      'Premium',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.60,
                      ),
                    ),
                    padding: EdgeInsets.only(
                      top: 20.h,
                      bottom: 20.h,
                      left: 39.w,
                      right: 39.w,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1C1C29),
                      borderRadius: BorderRadius.circular(40.r),
                      border: Border.all(
                        width: 2.w,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ],
        );
      }),
    ),
  );
}

saveImageSheet(BuildContext context) {
  // Open the database connection
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    constraints: BoxConstraints(
      maxHeight: MediaQuery.sizeOf(context).height * 0.35,
    ),
    barrierColor: Colors.transparent,
    elevation: 0,
    isDismissible: false,
    backgroundColor: Colors.transparent,
    builder: (context) => BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: StatefulBuilder(builder: (context, changeState) {
        return Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                  color: iconColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(35.r),
                    topRight: Radius.circular(35.r),
                  ),
                ),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.sizeOf(context).height * 0.35,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                children: [
                  SizedBox(
                    height: 30.h,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.w),
                    width: 115.w,
                    height: 10.h,
                    decoration: ShapeDecoration(
                      color: const Color(0xFF808080),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3.r),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 70.h,
                  ),
                  Text(
                    "Save Image",
                    style: TextStyle(
                      fontSize: 23.sp,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.61,
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  const Spacer(),
                  Consumer<SelectionProvider>(
                    builder: (context, provider, child) {
                      return GradientButtonCustom(
                        onTap: () async {
                          debugPrint(
                              "DebugPrint--->${Provider.of<SelectionProvider>(context, listen: false).generatePreview}");
                          provider.addDialog("Saving Image to Gallery...");
                          generateDialog(
                            context,
                            LottieBuilder.asset(
                                "assets/icons/AI_Processing.json"),
                          );
                          Future.delayed(const Duration(seconds: 2))
                              .then((value) => {
                                    finish(context),
                                    saveImageToGallery(
                                            Provider.of<SelectionProvider>(
                                                    context,
                                                    listen: false)
                                                .generatePreview)
                                        .then((value) => {
                                              db?.saveCreations(
                                                imagePath: basename(value),
                                                description: Provider.of<
                                                            SelectionProvider>(
                                                        context,
                                                        listen: false)
                                                    .generatePrompt,
                                                isFavorite: true,
                                              ),
                                              Provider.of<SelectionProvider>(
                                                      context,
                                                      listen: false)
                                                  .fetchAllCreatedFiles(),
                                              // Insert a new row into the MyCreation table
                                              finish(context),
                                              debugPrint(
                                                  "SaveImageTOGallery---->$value")
                                            })
                                  });
                        },
                        height: 75.h,
                        width: MediaQuery.sizeOf(context).width * 0.7,
                        decoration: ShapeDecoration(
                          gradient: gradientColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(33.r),
                          ),
                        ),
                        btnText: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/icons/video.png",
                              width: 26.38.w,
                              height: 29.98.h,
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Generate',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 0.60,
                                  ),
                                ),
                                Text(
                                  'Watch Ad',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w300,
                                    letterSpacing: 0.45,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  smallButton(
                    onTap: () {},
                    icon: Image.asset(
                      "assets/icons/progen.png",
                      height: 25.h,
                      width: 25.w,
                    ),
                    width: MediaQuery.sizeOf(context).width * 0.7,
                    btntext: Text(
                      'Premium',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.60,
                      ),
                    ),
                    padding: EdgeInsets.only(
                      top: 20.h,
                      bottom: 20.h,
                      left: 39.w,
                      right: 39.w,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1C1C29),
                      borderRadius: BorderRadius.circular(40.r),
                      border: Border.all(
                        width: 2.w,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ],
        );
      }),
    ),
  );
}
