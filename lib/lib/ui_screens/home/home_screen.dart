// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:ai_art_gen/constants/color_constants.dart';
import 'package:ai_art_gen/models/aspectratio_model.dart';
import 'package:ai_art_gen/provider/selection_provider.dart';
import 'package:ai_art_gen/reuableWidget/dialog.dart';
import 'package:ai_art_gen/ui_screens/drawer/side_drawer.dart';
import 'package:ai_art_gen/ui_screens/premium/dark_premium_screen.dart';
import 'package:ai_art_gen/ui_screens/premium/premium_discount.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:drift/drift.dart' as drift;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../../Utils/common_functions.dart';
import '../../constants/api_end_points_constants.dart';
import '../../database/database.dart';
import '../../main.dart';
import '../../reuableWidget/button.dart';
import '../result/result_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoaded = true;
  bool editingText = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String selectedStyle = "";

  @override
  void initState() {
    super.initState();
    Provider.of<SelectionProvider>(context, listen: false).fetchArtImages();

    Provider.of<SelectionProvider>(context, listen: false)
        .fetchModelsDataList();
    Provider.of<SelectionProvider>(context, listen: false)
        .fetchInspirationsDataList();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_scaffoldKey.currentState!.isDrawerOpen) {
          _scaffoldKey.currentState!.closeDrawer();
        } else {
          showExitConfirmation(context);
        }
        return false;
      },
      child: Consumer<SelectionProvider>(builder: (context, value, child) {
        return SafeArea(
          child: Scaffold(
            key: _scaffoldKey,
            drawer: MainDrawer(
              scaffoldKey: _scaffoldKey,
            ),
            appBar: AppBar(
              scrolledUnderElevation: 0.0,
              toolbarHeight: 110.h,
              elevation: 0,
              leadingWidth: 110.w,
              title: Text(
                'AI Art Generator',
                style: TextStyle(
                    fontSize: 28.sp,
                    color: white,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w500),
              ),
              titleSpacing: -15.w,
              leading: IconButton(
                onPressed: () {
                  _scaffoldKey.currentState?.openDrawer();
                },
                icon: Image.asset(
                  "assets/menu.png",
                  width: 30.w,
                  height: 30.h,
                ),
              ),
              actions: [
                Visibility(
                  visible: value.genDiscount,
                  replacement: GestureDetector(
                    onTap: () {
                      const PremiumScreen().launch(context);
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                        top: 10.h,
                        bottom: 10.h,
                        left: 15.w,
                        right: 15.w,
                      ),
                      decoration: ShapeDecoration(
                        gradient: gradientColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(33.r),
                        ),
                      ),
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/icons/Premium.png",
                            width: 25.w,
                            height: 25.h,
                          ),
                          SizedBox(
                            width: 12.w,
                          ),
                          Text(
                            'PRO',
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1.40,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          const PremiumDiscountScreen().launch(context);
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                            top: 10.h,
                            bottom: 10.h,
                            left: 20.w,
                            right: 20.w,
                          ),
                          decoration: ShapeDecoration(
                            gradient: gradientColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(33.r),
                            ),
                          ),
                          child: Row(
                            children: [
                              Text(
                                '50',
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1.40,
                                ),
                              ),
                              LottieBuilder.asset(
                                "assets/icons/Discount.json",
                                width: 30.w,
                                height: 30.h,
                              ),
                              // SizedBox(
                              //   width: 12.w,
                              // ),
                            ],
                          ),
                        ),
                      ),
                      Opacity(
                        opacity: 0.80,
                        child: Text(
                          '20 : 40 : 00',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 40.w,
                ),
              ],
            ),
            body: !isLoaded
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        LottieBuilder.asset(
                          "assets/icons/No internet.json",
                          width: 320.w,
                          height: 150.h,
                        ),
                        Text(
                          'No Internet',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 30.sp,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            letterSpacing: 2.10,
                          ),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        Text(
                          'Something went wrong with your connection, \nplease check and try again',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w300,
                            letterSpacing: 1.12,
                          ),
                        ),
                        SizedBox(
                          height: 40.h,
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            'Try Again',
                            style: TextStyle(
                              color: complColor,
                              fontSize: 22.sp,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              letterSpacing: 1.54,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : SizedBox(
                    height: MediaQuery.sizeOf(context).height,
                    width: MediaQuery.sizeOf(context).width,
                    child: Padding(
                      padding: EdgeInsets.only(
                        // top: 12.h,
                        left: 40.w,
                        right: 40.w,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Enter Prompt',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.sp,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
// TextField
                            Container(
                              margin: EdgeInsets.only(
                                top: 15.h,
                                bottom: 40.h,
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
                                  !value.editingText &&
                                          value.promptTextController.text == ''
                                      ? Align(
                                          alignment: Alignment.topLeft,
                                          child: SizedBox(
                                            width: 20.w,
                                            height: 20.h,
                                            child: Image.asset(
                                              "assets/icons/pencil.png",
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        )
                                      : const SizedBox.shrink(),
                                  TextFormField(
                                    buildCounter: (context,
                                        {currentLength = 0,
                                        isFocused = false,
                                        maxLength}) {
                                      return SizedBox(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
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
                                                      value.textClear();
                                                      value.changeEdit(false);
                                                      setState(() {});
                                                    },
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.all(2.sp),
                                                      decoration:
                                                          const BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color:
                                                            Color(0xff2C2B39),
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
                                    textAlignVertical: TextAlignVertical.top,
                                    onTapOutside: (event) {
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                    },
                                    onFieldSubmitted: (text) {
                                      value.changeEdit(true);
                                    },
                                    // onChanged: (text) {
                                    //   text.isEmpty
                                    //       ? value.changeEdit(false)
                                    //       : value.changeEdit(true);
                                    // },
                                    textInputAction: TextInputAction.done,
                                    controller: value.promptTextController,
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                    ),
                                    maxLength: 500,
                                    keyboardType: TextInputType.multiline,
                                    maxLines: 7,
                                    // expands: true,
                                    decoration: InputDecoration(
                                      hintText: "What do you want to create?",
                                      hintStyle: TextStyle(
                                        color: const Color(0xFFA3A2A7),
                                        fontSize: 16.sp,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400,
                                      ),
                                      contentPadding: value.editingText
                                          ? EdgeInsets.zero
                                          : EdgeInsets.only(
                                              left: 25.w,
                                            ),

                                      isDense: true,
                                      // prefixIconConstraints: BoxConstraints(
                                      //   maxWidth: 20.w,
                                      //   maxHeight: 20.h,
                                      //   minHeight: 0.h,
                                      //   minWidth: 0.w,
                                      // ),

                                      // prefixIcon: Visibility(
                                      //   visible: !value.editingText,
                                      //   replacement: SizedBox.shrink(),
                                      //   child: Image.asset(
                                      //     "assets/icons/pencil.png",
                                      //     width: 20.w,
                                      //     height: 20.h,
                                      //     // fit: BoxFit.contain,
                                      //   ),
                                      // ),
                                      border: const UnderlineInputBorder(
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                  ),
                                  !value.editingText &&
                                          value.promptTextController.text == ''
                                      ? Align(
                                          alignment: Alignment.topRight,
                                          child: GestureDetector(
                                            onTap: () {
                                              historySheet(context);
                                            },
                                            child: SizedBox(
                                              width: 20.w,
                                              height: 20.h,
                                              child: Image.asset(
                                                "assets/icons/options.png",
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          ),
                                        )
                                      : const SizedBox.shrink(),
                                  Align(
                                    alignment: Alignment.bottomLeft,
                                    child: SizedBox(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              print("Creativity");
                                              value.setTryPrompt(value
                                                  .inspirations[Random()
                                                      .nextInt(value
                                                          .inspirations.length)]
                                                  .command);
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
                                                          value
                                                              .stylesImages[
                                                                  index]
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
                                                            BorderRadius
                                                                .circular(15.r),
                                                        child:
                                                            CachedNetworkImage(
                                                          width: 100.w,
                                                          height: 110.h,
                                                          fit: BoxFit.cover,
                                                          imageUrl: value
                                                              .stylesImages[
                                                                  index]
                                                              .thumb
                                                              .toString(),
                                                          placeholder:
                                                              (context, url) =>
                                                                  SizedBox(
                                                            width:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                            height:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height,
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                color:
                                                                    iconColor,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20.r),
                                                              ),
                                                              padding:
                                                                  EdgeInsets
                                                                      .only(
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
                                                                    height:
                                                                        85.h,
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
                                                          value
                                                                  .stylesImages[
                                                                      index]
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
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontSize: 16.sp,
                                                      fontFamily: 'Poppins',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ))
                                              ],
                                            ),
                                          ),
                                          value.stylesImages[index].isPro ==
                                                  "true"
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
                            // Aspect Ratio
                            ListTile(
                              visualDensity: const VisualDensity(vertical: -4),
                              contentPadding: EdgeInsets.zero,
                              dense: true,
                              splashColor: transparentColor,
                              leading: Text(
                                'Aspect Ratio',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              trailing: GestureDetector(
                                onTap: () {
                                  ratioSheet(context);
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

                            HorizontalList(
                              itemCount: ratioBox.length,
                              padding: EdgeInsets.only(
                                top: 20.h,
                                bottom: 30.h,
                              ),
                              spacing: 10.w,
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
                                    // top: 15.h,
                                    // bottom: 15.h,
                                    // left: 20.w,
                                    // right: 20.w,
                                    // ),

                                    decoration: ShapeDecoration(
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                            width: value.selectedRatio == index
                                                ? 2.w
                                                : 0.20.w,
                                            color: value.selectedRatio == index
                                                ? borderColor
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
                                            color: value.selectedRatio == index
                                                ? mainColor
                                                : const Color(0xFFCDCDCE),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(3.r)),
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
                                  bottom: 67.h,
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
// generate button
                            GradientButtonCustom(
                              onTap: () async {
                                if (value
                                    .promptTextController.text.isNotEmpty) {
                                  if (value.clickGen < 3 &&
                                      !value.genDiscount) {
                                    value.addClick();
                                    value.setDiscountGen();
                                    print("${value.clickGen}");
                                  }
                                  // print(value.clickGen);
                                  if (value.clickGen >= 3 &&
                                      !value.genDiscount) {
                                    // print("inside reset");
                                    value.resetClick();
                                    value.addClick();
                                  }
                                  if (value.genDiscount) {
                                    Timer(const Duration(seconds: 30), () {
                                      value.resetDiscount();
                                      setState(() {});
                                      // print(value.clickGen);
                                    });
                                  }

                                  value.addDialog("AI Analysis Prompt");
                                  generateDialog(
                                    context,
                                    LottieBuilder.asset(
                                        "assets/icons/AI_Processing.json"),
                                  );
                                  value.initialize();

                                  PromptHistoryCompanion history =
                                      PromptHistoryCompanion(
                                          prompt: drift.Value(
                                              value.promptTextController.text),
                                          id: drift.Value(
                                              Random().nextInt(25)));

                                  await db?.savePromptHistory(history);

                                  value.promptMain =
                                      value.promptTextController.text;

                                  ///----Api Call
                                  generateImageWithDio(
                                      value.promptTextController.text, value);
                                } else {
                                  Fluttertoast.showToast(
                                    msg: "Enter Prompt please!",
                                    backgroundColor: iconColor.withOpacity(0.8),
                                  );
                                }
                              },
                              height: 75.h,
                              width: 640.w,
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
                              height: 40.h,
                            ),
                            Row(
                              children: [
                                Text(
                                  'Inspirations',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 23.sp,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Visibility(
                              visible: value.inspirations.isNotEmpty,
                              replacement: Center(
                                child: LottieBuilder.asset(
                                  "assets/icons/Processing_Image.json",
                                  width: 120.w,
                                  height: 120.h,
                                ),
                              ),
                              child: value.inspirations.isNotEmpty
                                  ? SizedBox(
                                      height:
                                          MediaQuery.sizeOf(context).height *
                                              0.5,
                                      child: GridView.builder(
                                        physics: const BouncingScrollPhysics(),
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          mainAxisExtent: 340.h,
                                          mainAxisSpacing: 10.h,
                                          crossAxisSpacing: 10.w,
                                        ),
                                        itemCount: value.inspirations.length,
                                        itemBuilder: (context, index) {
                                          return !isLoaded
                                              ? Container(
                                                  decoration: BoxDecoration(
                                                    color: iconColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.r),
                                                  ),
                                                  padding: EdgeInsets.only(
                                                    top: 50.h,
                                                    right: 80.w,
                                                    left: 80.w,
                                                    bottom: 50.h,
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      LottieBuilder.asset(
                                                        "assets/icons/Processing_Image.json",
                                                      ),
                                                      Text(
                                                        "Generating...",
                                                        // overflow: TextOverflow.ellipsis,
                                                        style: TextStyle(
                                                          fontSize: 20.sp,
                                                          color: const Color(
                                                              0xFF8F8E95),
                                                          fontFamily: 'Poppins',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              : SizedBox(
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        decoration:
                                                            ShapeDecoration(
                                                          color: const Color(
                                                              0xFF12111D),
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20.r),
                                                          ),
                                                        ),
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20.r),
                                                          child: Stack(
                                                            children: [
                                                              GestureDetector(
                                                                onTap: () {
                                                                  print(
                                                                      "OnTap---->${value.inspirations[index].command}----${value.inspirations[index].path}");
                                                                  value.setTryPrompt(value
                                                                          .inspirations[
                                                                              index]
                                                                          .command ??
                                                                      "");
                                                                },
                                                                child:
                                                                    CachedNetworkImage(
                                                                  width: 300.w,
                                                                  height: 280.h,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  imageUrl: value
                                                                          .inspirations[
                                                                              index]
                                                                          .path ??
                                                                      "",
                                                                  placeholder:
                                                                      (context,
                                                                              url) =>
                                                                          SizedBox(
                                                                    width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width,
                                                                    height: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height,
                                                                    child:
                                                                        Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color:
                                                                            iconColor,
                                                                        borderRadius:
                                                                            BorderRadius.circular(20.r),
                                                                      ),
                                                                      padding:
                                                                          EdgeInsets
                                                                              .only(
                                                                        top: 10
                                                                            .h,
                                                                        right:
                                                                            10.w,
                                                                        left: 10
                                                                            .w,
                                                                        bottom:
                                                                            10.h,
                                                                      ),
                                                                      child:
                                                                          Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          LottieBuilder
                                                                              .asset(
                                                                            "assets/icons/Processing_Image.json",
                                                                            width:
                                                                                85.w,
                                                                            height:
                                                                                85.h,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  errorWidget: (context,
                                                                          url,
                                                                          error) =>
                                                                      const Icon(
                                                                          Icons
                                                                              .error),
                                                                ),
                                                              ),
                                                              Positioned(
                                                                left: 10.w,
                                                                top: 10.h,
                                                                child:
                                                                    GestureDetector(
                                                                  onTap: () {
                                                                    if (value
                                                                            .inspirations[index]
                                                                            .isFavorite ??
                                                                        false) {
                                                                      print(
                                                                          "before delete");
                                                                      db?.deleteInspiration(
                                                                          value.inspirations[index].path ??
                                                                              "");
                                                                      print(
                                                                          "after delete");
                                                                    } else {
                                                                      InspirationFavoriteCompanion model = InspirationFavoriteCompanion(
                                                                          id: drift.Value(
                                                                              index),
                                                                          path: drift.Value(value.inspirations[index].path ??
                                                                              ""),
                                                                          command: drift.Value(value.inspirations[index].command ??
                                                                              ""),
                                                                          proUserAccess: drift.Value(value.inspirations[index].pro_user_access ??
                                                                              false),
                                                                          isFavorite:
                                                                              const drift.Value(true));
                                                                      db?.saveInspiration(
                                                                          model);
                                                                    }
                                                                    Provider.of<SelectionProvider>(
                                                                            context,
                                                                            listen:
                                                                                false)
                                                                        .fetchInspirationsDataList();
                                                                  },
                                                                  child: Icon(
                                                                    value.inspirations[index].isFavorite ??
                                                                            false
                                                                        ? Icons
                                                                            .favorite
                                                                        : Icons
                                                                            .favorite_border,
                                                                    color: value.inspirations[index].isFavorite ??
                                                                            false
                                                                        ? favorite
                                                                        : null,
                                                                    size: 38.sp,
                                                                  ),
                                                                ),
                                                              ),
                                                              Positioned(
                                                                bottom: 10.h,
                                                                right: 10.w,
                                                                child:
                                                                    GestureDetector(
                                                                  onTap: () {
                                                                    print(
                                                                        "Try");
                                                                    tryDialog(
                                                                        context,
                                                                        () {},
                                                                        value.inspirations[
                                                                            index],
                                                                        value
                                                                            .promptTextController);
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    padding:
                                                                        EdgeInsets
                                                                            .only(
                                                                      left:
                                                                          15.w,
                                                                      right:
                                                                          15.w,
                                                                      top: 5.h,
                                                                      bottom:
                                                                          5.h,
                                                                    ),
                                                                    decoration:
                                                                        ShapeDecoration(
                                                                      gradient:
                                                                          gradientColor,
                                                                      shape:
                                                                          RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(33.r),
                                                                      ),
                                                                    ),
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .min,
                                                                      children: [
                                                                        Text(
                                                                          'TRY',
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                14.sp,
                                                                            fontFamily:
                                                                                'Poppins',
                                                                            fontWeight:
                                                                                FontWeight.w400,
                                                                            letterSpacing:
                                                                                0.98,
                                                                          ),
                                                                        ),
                                                                        Icon(
                                                                          Icons
                                                                              .arrow_forward,
                                                                          size:
                                                                              20.sp,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 5.h,
                                                      ),
                                                      Text(
                                                        value
                                                                .inspirations[
                                                                    index]
                                                                .command ??
                                                            "",
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 2,
                                                        style: TextStyle(
                                                          fontSize: 12.sp,
                                                          fontFamily: 'Poppins',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                        },
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
          ),
        );
      }),
    );
  }

  Future<void> generateImageWithDio(String prompt, SelectionProvider value,
      {int steps = 20,
      int batchSize = 6,
      int cfgScale = 9,
      String negativePrompt = "",
      String url = ApiEndPoints.artGenBaseUrl}) async {
    if (kDebugMode) {
      print(
          "allOptionsSelectedByUser---->${value.selectedRatioMap['width']}------${value.selectedRatioMap['height']}----${value.stepsValue * 10}----${value.gfsValue * 3}---${value.batchSize}----${value.negativePrompt}");
    }
    steps = (value.stepsValue * 10).toInt();
    batchSize = (value.batchSize).toInt();
    cfgScale = (value.gfsValue * 3).toInt();
    negativePrompt = value.negativePrompt.isEmpty == true
        ? value.negativeDefaultText
        : value.negativePrompt;
    final payload = {
      "prompt": prompt,
      "negative_prompt": negativePrompt,
      "styles": [value.selectedStyle],
      "seed": -1,
      "steps": steps,
      "width": value.selectedRatioMap['width'],
      "height": value.selectedRatioMap['height'],
      "batch_size": 1,
      "cfg_scale": cfgScale
    };
    debugPrint("PayloadOnHome--->${payload.values}");
    try {
      value.newToken();
      CancelToken cancelToken = value.cancelApi;
      final dio = Dio();
      final response = await dio.post(
        '$url/sdapi/v1/txt2img',
        data: json.encode(payload),
        options: Options(
          contentType: Headers.jsonContentType,
        ),
        cancelToken: cancelToken,
      );

      if (response.statusCode == 200) {
        imageCache.clear();
        imageCache.clearLiveImages();
        print("apiResponse---->${response.data}");
        List<dynamic> imagesList = response.data['images'];
        List<int> imageBytes = base64.decode(imagesList[0]);
        print("apiResponse---->${imageBytes.length}");
        var returnedPath =
            await copyBytesToFile(imageBytes, "aiArtGenOutput.png");
        value.addGenerated(returnedPath);
        value.addSelectedPrompt(value.promptTextController.text);
        Navigator.pop(context);
        value.textClear();
        const ResultScreen().launch(context);
      } else {
        if (kDebugMode) {
          print('Failed to get the image. Status code: ${response.statusCode}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error during image generation: $e');
      }
    }
  }
}
