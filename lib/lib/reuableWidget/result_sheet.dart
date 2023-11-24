import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../../constants/color_constants.dart';
import '../../models/image_model.dart';
import '../../provider/selection_provider.dart';
import '../../reuableWidget/dialog.dart';
import '../ui_screens/result/result_screen.dart';
import 'button.dart';

class ResultSheet extends StatefulWidget {
  String prompt;

  ResultSheet({super.key, required this.prompt});

  @override
  State<ResultSheet> createState() => _ResultSheetState();
}

class _ResultSheetState extends State<ResultSheet> {
  bool editingText = false;
  bool isLoaded = true;
  double sheetSize = 0.0;

  final numberList = [
    "1",
    "3",
    "5",
    "7",
  ];

  bool isPro = false;

  final dragController = DraggableScrollableController();

  final promptTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    promptTextController.text = widget.prompt;
    dragController.addListener(() {
      if (dragController.isAttached) {
        sheetSize = dragController.size;
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    dragController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        initialChildSize: 0.68,
        expand: false,
        controller: dragController,
        builder: (context, scrollController) {
          return Consumer<SelectionProvider>(builder: (context, value, child) {
            return SingleChildScrollView(
              controller: scrollController,
              child: StatefulBuilder(
                builder: (context, changeState) {
                  return Container(
                    padding: EdgeInsets.only(
                      top: 20.h,
                      left: 40.w,
                      right: 40.w,
                    ),
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    // width: double.maxFinite,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50.r),
                        topRight: Radius.circular(50.r),
                      ),
                      color: iconColor,
                    ),
                    child: Column(
                      children: [
                        // top handle
                        sheetSize == 1.0
                            ? SizedBox(
                                height: 30.h,
                              )
                            : const SizedBox.shrink(),
                        sheetSize == 1.0
                            ? const SizedBox.shrink()
                            : Container(
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
                          height: 35.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            sheetSize == 1.0
                                ? GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(2.sp),
                                      child: Icon(
                                        Icons.keyboard_arrow_down,
                                        size: 40.sp,
                                      ),
                                    ),
                                  )
                                : SizedBox(
                                    width: 5.w,
                                  ),
                            Text(
                              'Edit Input',
                              style: TextStyle(
                                fontSize: 23.sp,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                                letterSpacing: 1.61,
                              ),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 25.h,
                        ),

// TextField
                        Container(
                          margin: EdgeInsets.only(
                            top: 15.h,
                            bottom: 15.h,
                          ),
                          padding: EdgeInsets.only(
                            top: 18.h,
                            left: 20.w,
                            right: 10.w,
                            bottom: 15.h,
                          ),
                          width: 640.w,
                          height: 220.h,
                          decoration: ShapeDecoration(
                            color: iconColor,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  width: 0.10.w, color: Colors.white),
                              borderRadius: BorderRadius.circular(15.r),
                            ),
                          ),
                          child: Stack(
                            children: [
                              TextField(
                                buildCounter: (context,
                                    {currentLength = 0,
                                    isFocused = false,
                                    maxLength}) {
                                  return SizedBox(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Opacity(
                                          opacity: 0.50,
                                          child: Text(
                                            '$currentLength/$maxLength',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 18.sp,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5.w,
                                        ),
                                        currentLength == 0
                                            ? const SizedBox.shrink()
                                            : GestureDetector(
                                                onTap: () {
                                                  promptTextController.clear();
                                                  setState(() {});
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.all(2.sp),
                                                  decoration:
                                                      const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Color(0xff2C2B39),
                                                  ),
                                                  child: Icon(
                                                    Icons.close,
                                                    size: 28.sp,
                                                  ),
                                                ),
                                              ),
                                      ],
                                    ),
                                  );
                                },
                                onTapOutside: (event) {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  setState(() {
                                    editingText = false;
                                  });
                                },

                                textInputAction: TextInputAction.done,
                                controller: promptTextController,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                ),
                                maxLength: 500,
                                onSubmitted: (value) {
                                  editingText = false;
                                  setState(() {});
                                },
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                expands: true,
                                //
                                decoration: const InputDecoration(
                                    isDense: true,
                                    border: UnderlineInputBorder(
                                      borderSide: BorderSide.none,
                                    )),
                              ),
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: SizedBox(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          print("Creativity");
                                        },
                                        child: Container(
                                          width: 36.w,
                                          height: 36.h,
                                          padding: EdgeInsets.all(5.sp),
                                          decoration: const BoxDecoration(
                                            color: btnColor,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Image.asset(
                                            "assets/icons/creativity.png",
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          print("Microphone");
                                        },
                                        child: Container(
                                          width: 36.w,
                                          height: 36.h,
                                          padding: EdgeInsets.all(5.sp),
                                          decoration: const BoxDecoration(
                                            color: btnColor,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Image.asset(
                                              "assets/icons/microphone.png"),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
// Style
                        ListTile(
                          visualDensity: const VisualDensity(vertical: -4),
                          contentPadding: EdgeInsets.zero,
                          // onTap: () {
                          //   styleSheet(context);
                          // },
                          dense: true,
                          splashColor: transparentColor,
                          leading: Text(
                            'Styles',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          trailing: GestureDetector(
                            onTap: () {
                              styleSheet(context);
                            },
                            child: Container(
                              width: 30.w,
                              height: 30.h,
                              padding: EdgeInsets.all(6.sp),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: btnColor,
                              ),
                              child: Image.asset(
                                "assets/icons/left-arrow.png",
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),

                        Visibility(
                          visible: value.stylesImages.isNotEmpty,
                          replacement: Center(
                            child: LottieBuilder.asset(
                              "assets/icons/Processing_Image.json",
                              width: 120.w,
                              height: 120.h,
                            ),
                          ),
                          child: HorizontalList(
                            itemCount: value.stylesImages.length,
                            padding: EdgeInsets.only(
                              top: 0.h,
                              bottom: 30.h,
                            ),
                            spacing: 3.w,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  // value.changeSelected(index);
                                  value.changeSelectedStyle(
                                      value.stylesImages[index].name);
                                },
                                child: SizedBox(
                                  child: Stack(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                          right: 10.w,
                                          top: 10.h,
                                        ),
                                        padding: EdgeInsets.only(
                                          top: 6.h,
                                          bottom: 11.h,
                                          left: 6.w,
                                          right: 6.w,
                                        ),
                                        decoration: ShapeDecoration(
                                          color: iconColor,
                                          shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                              width: 2.w,
                                              color: value.selectedStyle ==
                                                      value.stylesImages[index]
                                                          .name
                                                  ? borderColor
                                                  : transparentColor,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(15.r),
                                          ),
                                        ),
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              child: Stack(
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.r),
                                                    child: CachedNetworkImage(
                                                      width: 100.w,
                                                      height: 110.h,
                                                      fit: BoxFit.cover,
                                                      imageUrl: value
                                                          .stylesImages[index]
                                                          .thumb
                                                          .toString(),
                                                      placeholder:
                                                          (context, url) =>
                                                              SizedBox(
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        height: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .height,
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: iconColor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20.r),
                                                          ),
                                                          padding:
                                                              EdgeInsets.only(
                                                            top: 10.h,
                                                            right: 10.w,
                                                            left: 10.w,
                                                            bottom: 10.h,
                                                          ),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              LottieBuilder
                                                                  .asset(
                                                                "assets/icons/Processing_Image.json",
                                                                width: 85.w,
                                                                height: 85.h,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          const Icon(
                                                              Icons.error),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    right: 6.w,
                                                    bottom: 6.h,
                                                    child: Icon(
                                                      value.stylesImages[index]
                                                              .isFavorite!
                                                          ? Icons.favorite
                                                          : Icons
                                                              .favorite_border,
                                                      color: value
                                                              .stylesImages[
                                                                  index]
                                                              .isFavorite!
                                                          ? favorite
                                                          : null,
                                                      size: 20.sp,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5.h,
                                            ),
                                            Text(
                                                value.stylesImages[index]
                                                        .name ??
                                                    "",
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 16.sp,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w400,
                                                ))
                                          ],
                                        ),
                                      ),
                                      value.stylesImages[index].isPro == "true"
                                          ? Positioned(
                                              right: 0.w,
                                              child: Image.asset(
                                                "assets/styles/pro.png",
                                                width: 35.w,
                                                height: 35.h,
                                              ),
                                            )
                                          : const SizedBox.shrink(),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

// Advanced settings
                        Row(
                          children: [
                            Text(
                              'Advance Settings',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),

                        GestureDetector(
                          onTap: () {
                            advancedSettingSheet(context);
                          },
                          child: Container(
                            padding: EdgeInsets.all(15.sp),
                            margin: EdgeInsets.only(
                              top: 15.h,
                              bottom: 15.h,
                            ),
                            decoration: ShapeDecoration(
                              color: iconColorSecondary,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    width: 0.20.w, color: Colors.white),
                                borderRadius: BorderRadius.circular(15.r),
                              ),
                            ),
                            child: Row(
                              children: [
                                Opacity(
                                  opacity: 0.80,
                                  child: Text(
                                    'Advance Settings',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                Container(
                                  width: 30.w,
                                  height: 30.h,
                                  padding: EdgeInsets.all(6.sp),
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: btnColor,
                                  ),
                                  child: Image.asset(
                                    "assets/icons/left-arrow.png",
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
// generate button
                        GradientButtonCustom(
                          onTap: () {
                            if (promptTextController.text.isNotEmpty) {
                              if (value.clickGen < 3 && !value.genDiscount) {
                                value.addClick();
                                value.setDiscountGen();
                                // print(value.clickGen);
                              }
                              // print(value.clickGen);
                              if (value.clickGen >= 3 && !value.genDiscount) {
                                // print("inside reset");
                                value.resetClick();
                                value.addClick();
                              }
                              if (value.genDiscount) {
                                Timer(const Duration(seconds: 20), () {
                                  value.resetDiscount();
                                  setState(() {});
                                  // print(value.clickGen);
                                });
                              }
                            } else {
                              Fluttertoast.showToast(
                                msg: "Enter Prompt please!",
                                backgroundColor: iconColor.withOpacity(0.8),
                              );
                            }
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
                            color: Color(0xFF1C1C29),
                            borderRadius: BorderRadius.circular(40.r),
                            border: Border.all(
                              width: 2.w,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        // bottom handle
                        const Spacer(),
                        sheetSize == 1.0
                            ? Container(
                                width: 115.w,
                                height: 10.h,
                                decoration: ShapeDecoration(
                                  color: const Color(0xFF808080),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(3.r),
                                  ),
                                ),
                              )
                            : const SizedBox.shrink(),
                        SizedBox(
                          height: 20.h,
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          });
        });
  }
}
