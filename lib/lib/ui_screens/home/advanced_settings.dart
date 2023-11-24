import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:super_tooltip/super_tooltip.dart';

import '../../constants/color_constants.dart';
import '../../models/aspectratio_model.dart';
import '../../models/image_model.dart';
import '../../provider/selection_provider.dart';
import '../../reuableWidget/dialog.dart';

class AdvancedSettings extends StatefulWidget {
  const AdvancedSettings({super.key});

  @override
  State<AdvancedSettings> createState() => _AdvancedSettingsState();
}

class _AdvancedSettingsState extends State<AdvancedSettings> {
  bool isLoaded = true;
  double sheetSize = 0.0;

  final numberList = [
    "1",
    "3",
    "5",
    "7",
  ];

  bool isPro = false;

  // final promptTipController = SuperTooltipController();
  // final stepsTipController = SuperTooltipController();
  // final gfsTipController = SuperTooltipController();
  // final seedTipController = SuperTooltipController();
  final dragController = DraggableScrollableController();
  final negativePromptController = TextEditingController();
  final seedController = TextEditingController();

  @override
  void initState() {
    super.initState();
    dragController.addListener(() {
      if (dragController.isAttached) {
        sheetSize = dragController.size;
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    // promptTipController.dispose();
    // stepsTipController.dispose();
    // gfsTipController.dispose();
    // seedTipController.dispose();
    dragController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        initialChildSize: 0.55,
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
                                        size: 45.sp,
                                      ),
                                    ),
                                  )
                                : SizedBox(
                                    width: 5.w,
                                  ),
                            Text(
                              'Advanced Settings',
                              style: TextStyle(
                                fontSize: 23.sp,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                                letterSpacing: 1.61,
                              ),
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 25.h,
                        ),

                        // Negative Prompt
                        Row(
                          children: [
                            Text(
                              'Negative Prompt',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.sp,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Tooltip(
                              richMessage: TextSpan(
                                  text: "What is Negative Prompt\n",
                                  style: TextStyle(
                                    color: white,
                                    fontSize: 18.sp,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                  ),
                                  children: [
                                    TextSpan(
                                      text:
                                          "Negative prompts in AI art generators tell the generator what to not include in the generated image.",
                                      style: TextStyle(
                                        color: white,
                                        fontSize: 15.sp,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ]),
                              verticalOffset: 30.h,
                              padding: EdgeInsets.only(
                                top: 20.h,
                                left: 20.w,
                                right: 20.w,
                                bottom: 20.h,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF2B2939),
                                borderRadius: BorderRadius.circular(15.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0x8535353B),
                                    blurRadius: 3.r,
                                    offset: const Offset(3, 3),
                                    spreadRadius: 0,
                                  )
                                ],
                              ),
                              triggerMode: TooltipTriggerMode.tap,
                              showDuration: const Duration(milliseconds: 3000),
                              waitDuration: const Duration(milliseconds: 3000),
                              margin: EdgeInsets.only(
                                left: 20.w,
                                right: 20.w,
                              ),
                              child: Container(
                                margin: EdgeInsets.all(5.sp),
                                padding: EdgeInsets.all(5.sp),
                                child: Image.asset(
                                  "assets/icons/tips.png",
                                  width: 20.w,
                                  height: 20.h,
                                  color: const Color(0xff246DFF),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: 15.h,
                            bottom: 20.h,
                          ),
                          padding: EdgeInsets.only(
                            top: 18.h,
                            left: 20.w,
                            right: 15.w,
                            bottom: 20.h,
                          ),
                          width: 640.w,
                          height: 180.h,
                          decoration: ShapeDecoration(
                            color: const Color(0xFF1B1927),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  width: 0.10.w, color: Colors.white),
                              borderRadius: BorderRadius.circular(15.r),
                            ),
                          ),
                          child: Stack(
                            children: [
                              !value.editingText &&
                                      negativePromptController.text == ''
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
                                                  negativePromptController
                                                      .clear();
                                                  value.changeEdit(false);
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
                                textAlignVertical: TextAlignVertical.top,
                                onTapOutside: (event) {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                },
                                onChanged: (text) {
                                  if (negativePromptController.text.isEmpty) {
                                    value.negativePrompt = "";
                                  } else {
                                    value.setNegativePrompt(
                                        negativePromptController.text);
                                  }
                                  setState(() {
                                    negativePromptController.text.isEmpty
                                        ? value.changeEdit(false)
                                        : value.changeEdit(true);
                                  });
                                },
                                onEditingComplete: () {
                                  if (kDebugMode) {
                                    print("objectComplete");
                                  }
                                },
                                textInputAction: TextInputAction.done,
                                controller: negativePromptController,
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
                            ],
                          ),
                        ),
                        // Models
                        ListTile(
                          visualDensity: const VisualDensity(
                            vertical: -4,
                          ),
                          contentPadding: EdgeInsets.zero,
                          // onTap: () {
                          //   modelSheet(context);
                          // },
                          dense: true,
                          splashColor: transparentColor,
                          leading: Text(
                            'Model',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          trailing: GestureDetector(
                            onTap: () {
                              modelSheet(context);
                            },
                            child: Container(
                              width: 30.w,
                              height: 30.h,
                              padding: EdgeInsets.all(5.sp),
                              decoration: const ShapeDecoration(
                                shape: OvalBorder(),
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
                          visible: value.modelsImages.isNotEmpty,
                          replacement: Center(
                            child: LottieBuilder.asset(
                              "assets/icons/Processing_Image.json",
                              width: 120.w,
                              height: 120.h,
                            ),
                          ),
                          child: HorizontalList(
                            itemCount: value.modelsImages.length,
                            padding: EdgeInsets.only(
                              top: 0.h,
                              bottom: 10.h,
                            ),
                            spacing: 3.w,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  value.changeSelectedM(
                                      value.modelsImages[index].modelName);
                                  setState(() {});
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
                                          top: 8.h,
                                          bottom: 11.h,
                                          left: 8.w,
                                          right: 8.w,
                                        ),
                                        decoration: ShapeDecoration(
                                          color: const Color(0xFF1B1927),
                                          shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                              width: 2.w,
                                              color: value.selectedM ==
                                                      value.modelsImages[index]
                                                          .modelName
                                                  ? borderColor
                                                  : transparentColor,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(15.r),
                                          ),
                                        ),
                                        child: Column(
                                          children: [
                                            !isLoaded
                                                ? Container(
                                                    decoration: BoxDecoration(
                                                      color: iconColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.r),
                                                    ),
                                                    padding: EdgeInsets.only(
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
                                                        LottieBuilder.asset(
                                                          "assets/icons/Processing_Image.json",
                                                          width: 85.w,
                                                          height: 85.h,
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                : SizedBox(
                                                    child: Stack(
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      15.r),
                                                          child:
                                                              CachedNetworkImage(
                                                            width: 100.w,
                                                            height: 110.h,
                                                            fit: BoxFit.cover,
                                                            imageUrl: value
                                                                .modelsImages[
                                                                    index]
                                                                .filename
                                                                .toString(),
                                                            placeholder:
                                                                (context,
                                                                        url) =>
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
                                                                const Icon(Icons
                                                                    .error),
                                                          ),
                                                        ),
                                                        Positioned(
                                                          right: 6.w,
                                                          bottom: 6.h,
                                                          child: Icon(
                                                            value
                                                                    .modelsImages[
                                                                        index]
                                                                    .isFavorite
                                                                ? Icons.favorite
                                                                : Icons
                                                                    .favorite_border,
                                                            color: value
                                                                    .modelsImages[
                                                                        index]
                                                                    .isFavorite
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
                                            SizedBox(
                                              width: 100.w,
                                              child: Text(
                                                  value.modelsImages[index]
                                                      .modelName,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 10.sp,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w400,
                                                  )),
                                            )
                                          ],
                                        ),
                                      ),
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
                              ratioMSheet(context);
                            },
                            child: Container(
                              width: 30.w,
                              height: 30.h,
                              padding: EdgeInsets.all(5.sp),
                              decoration: const ShapeDecoration(
                                shape: OvalBorder(),
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
                            top: 0.h,
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
                                // width: 120.w,
                                height: 60.h,
                                padding: EdgeInsets.only(
                                  // top: 15.h,
                                  // bottom: 15.h,
                                  left: 23.w,
                                  right: 23.w,
                                ),

                                decoration: ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        width: value.selectedRatio == index
                                            ? 2.w
                                            : 0.20.w,
                                        color: value.selectedRatio == index
                                            ? borderColor
                                            : const Color(0xFFCDCDCE)),
                                    borderRadius: BorderRadius.circular(15.r),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
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

                        // Number of images
                        Row(
                          children: [
                            Text(
                              'How many images you want to generate?',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 22.sp,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),

                        Row(
                          children: [
                            HorizontalList(
                              wrapAlignment: WrapAlignment.start,
                              padding: EdgeInsets.only(
                                bottom: 20.h,
                              ),
                              spacing: 2.w,
                              // runSpacing: 10.w,
                              itemCount: numberList.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    value.changeNumSelect(index);
                                    value.setBatchSize(numberList[index]);
                                  },
                                  child: SizedBox(
                                    height: 80.h,
                                    width: 85.w,
                                    child: Stack(
                                      children: [
                                        Align(
                                          alignment: Alignment.center,
                                          child: Container(
                                            padding: EdgeInsets.only(
                                              top: 10.h,
                                              bottom: 10.h,
                                              right: 15.w,
                                              left: 15.w,
                                            ),
                                            margin: EdgeInsets.only(
                                              top: 10.h,
                                              right: 10.w,
                                              bottom: 10.h,
                                              left: 10.w,
                                            ),
                                            decoration: ShapeDecoration(
                                              color: const Color(0xFF1B1927),
                                              shape: RoundedRectangleBorder(
                                                side: BorderSide(
                                                  width: 2.w,
                                                  color:
                                                      value.numSelected == index
                                                          ? borderColor
                                                          : transparentColor,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(15.r),
                                              ),
                                            ),
                                            child: Center(
                                              child: Text(
                                                numberList[index],
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 18.sp,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        numberList[index] == '5' ||
                                                numberList[index] == '7'
                                            ? !isPro
                                                ? Positioned(
                                                    right: 0.w,
                                                    child: Image.asset(
                                                      "assets/styles/pro.png",
                                                      width: 28.w,
                                                      height: 28.h,
                                                    ),
                                                  )
                                                : const SizedBox.shrink()
                                            : const SizedBox.shrink(),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),

                        // Steps
                        Row(
                          children: [
                            Text(
                              'Steps',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.sp,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Tooltip(
                              richMessage: TextSpan(
                                  text: "What is Steps\n",
                                  style: TextStyle(
                                    color: white,
                                    fontSize: 18.sp,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                  ),
                                  children: [
                                    TextSpan(
                                      text:
                                          "Steps is a parameter that controls the quality and detail of the generated image. Higher steps will produce sharper and more detailed images, but they will also take longer to generate.",
                                      style: TextStyle(
                                        color: white,
                                        fontSize: 15.sp,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ]),
                              verticalOffset: 30.h,
                              padding: EdgeInsets.only(
                                top: 20.h,
                                left: 20.w,
                                right: 20.w,
                                bottom: 20.h,
                              ),
                              preferBelow: false,
                              decoration: BoxDecoration(
                                color: const Color(0xFF2B2939),
                                borderRadius: BorderRadius.circular(15.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0x8535353B),
                                    blurRadius: 3.r,
                                    offset: const Offset(3, 3),
                                    spreadRadius: 0,
                                  )
                                ],
                              ),
                              triggerMode: TooltipTriggerMode.tap,
                              showDuration: const Duration(milliseconds: 3000),
                              waitDuration: const Duration(milliseconds: 3000),
                              margin: EdgeInsets.only(
                                left: 20.w,
                                right: 20.w,
                              ),
                              child: Container(
                                margin: EdgeInsets.all(5.sp),
                                padding: EdgeInsets.all(5.sp),
                                child: Image.asset(
                                  "assets/icons/tips.png",
                                  width: 20.w,
                                  height: 20.h,
                                  color: const Color(0xff246DFF),
                                ),
                              ),
                            ),
                          ],
                        ),

                        FlutterSlider(
                          values: [value.stepsValue],
                          onDragging: (handlerIndex, lowerValue, upperValue) {
                            debugPrint("DebugPrint---->$lowerValue");
                            value.changeStep(lowerValue);
                            setState(() {});
                          },
                          max: 10,
                          min: 0,
                          handlerHeight: 25.h,
                          handlerWidth: 25.w,
                          tooltip: FlutterSliderTooltip(
                            alwaysShowTooltip: true,
                            positionOffset:
                                FlutterSliderTooltipPositionOffset(top: -30.h),
                            // format: (value) {
                            //   return (value.toInt()).toString();
                            // },
                            custom: (value) {
                              return Text(
                                (value.toInt()).toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w300,
                                ),
                              );
                            },
                          ),
                          handler: FlutterSliderHandler(
                            decoration: const BoxDecoration(
                              gradient: gradientColorT,
                              shape: BoxShape.circle,
                            ),
                            child: SizedBox(
                              width: 25.w,
                              height: 25.h,
                            ),
                          ),
                          handlerAnimation: const FlutterSliderHandlerAnimation(
                            curve: Curves.elasticOut,
                            reverseCurve: Curves.bounceIn,
                            duration: Duration(milliseconds: 50),
                            scale: 1.5,
                          ),
                          trackBar: FlutterSliderTrackBar(
                            inactiveTrackBar: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.r),
                              color: const Color(0xFF1B1927),
                              border: Border.all(
                                width: 0.20.w,
                                color: Colors.white,
                              ),
                            ),
                            activeTrackBar: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.r),
                              gradient: gradientColorT,
                            ),
                          ),
                        ),

                        // GFS
                        Row(
                          children: [
                            Text(
                              'GFS',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.sp,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Tooltip(
                              richMessage: TextSpan(
                                  text: "What is GFS scale\n",
                                  style: TextStyle(
                                    color: white,
                                    fontSize: 18.sp,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                  ),
                                  children: [
                                    TextSpan(
                                      text:
                                          "GFS scale controls the strength of the guidance field. Higher GFS scale results in an image more similar to the guidance field, while a lower GFS scale results in an image that is more creative.",
                                      style: TextStyle(
                                        color: white,
                                        fontSize: 15.sp,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ]),
                              verticalOffset: 30.h,
                              padding: EdgeInsets.only(
                                top: 20.h,
                                left: 20.w,
                                right: 20.w,
                                bottom: 20.h,
                              ),
                              preferBelow: false,
                              decoration: BoxDecoration(
                                color: const Color(0xFF2B2939),
                                borderRadius: BorderRadius.circular(15.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0x8535353B),
                                    blurRadius: 3.r,
                                    offset: const Offset(3, 3),
                                    spreadRadius: 0,
                                  )
                                ],
                              ),
                              triggerMode: TooltipTriggerMode.tap,
                              showDuration: const Duration(milliseconds: 3000),
                              waitDuration: const Duration(milliseconds: 3000),
                              margin: EdgeInsets.only(
                                left: 20.w,
                                right: 20.w,
                              ),
                              child: Container(
                                margin: EdgeInsets.all(5.sp),
                                padding: EdgeInsets.all(5.sp),
                                child: Image.asset(
                                  "assets/icons/tips.png",
                                  width: 20.w,
                                  height: 20.h,
                                  color: const Color(0xff246DFF),
                                ),
                              ),
                            ),
                          ],
                        ),

                        FlutterSlider(
                          values: [value.gfsValue],
                          onDragging: (handlerIndex, lowerValue, upperValue) {
                            value.changeGFS(lowerValue);
                            setState(() {});
                          },
                          max: 10,
                          min: 0,
                          handlerHeight: 25.h,
                          handlerWidth: 25.w,
                          tooltip: FlutterSliderTooltip(
                            alwaysShowTooltip: true,
                            positionOffset:
                                FlutterSliderTooltipPositionOffset(top: -30.h),
                            // format: (value) {
                            //   return (value.toInt()).toString();
                            // },
                            custom: (value) {
                              return Text(
                                (value.toInt()).toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w300,
                                ),
                              );
                            },
                          ),
                          handler: FlutterSliderHandler(
                            decoration: const BoxDecoration(
                              gradient: gradientColorT,
                              shape: BoxShape.circle,
                            ),
                            child: SizedBox(
                              width: 25.w,
                              height: 25.h,
                            ),
                          ),
                          handlerAnimation: const FlutterSliderHandlerAnimation(
                            curve: Curves.elasticOut,
                            reverseCurve: Curves.bounceIn,
                            duration: Duration(milliseconds: 50),
                            scale: 1.5,
                          ),
                          trackBar: FlutterSliderTrackBar(
                            inactiveTrackBar: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.r),
                              color: const Color(0xFF1B1927),
                              border: Border.all(
                                width: 0.20.w,
                                color: Colors.white,
                              ),
                            ),
                            activeTrackBar: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.r),
                              gradient: gradientColorT,
                            ),
                          ),
                        ),

                        // Seed
                        Row(
                          children: [
                            Text(
                              'Seed',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.sp,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Tooltip(
                              richMessage: TextSpan(
                                  text: "What is Seed\n",
                                  style: TextStyle(
                                    color: white,
                                    fontSize: 18.sp,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                  ),
                                  children: [
                                    TextSpan(
                                      text:
                                          "Seed is a random number that determines the output image. The same seed and prompt will always produce the same image, while different seeds will produce different images, even if the prompt is the same.",
                                      style: TextStyle(
                                        color: white,
                                        fontSize: 15.sp,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ]),
                              verticalOffset: 30.h,
                              padding: EdgeInsets.only(
                                top: 20.h,
                                left: 20.w,
                                right: 20.w,
                                bottom: 20.h,
                              ),
                              preferBelow: false,
                              decoration: BoxDecoration(
                                color: const Color(0xFF2B2939),
                                borderRadius: BorderRadius.circular(15.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0x8535353B),
                                    blurRadius: 3.r,
                                    offset: const Offset(3, 3),
                                    spreadRadius: 0,
                                  )
                                ],
                              ),
                              triggerMode: TooltipTriggerMode.tap,
                              showDuration: const Duration(milliseconds: 3000),
                              waitDuration: const Duration(milliseconds: 3000),
                              margin: EdgeInsets.only(
                                left: 20.w,
                                right: 20.w,
                              ),
                              child: Container(
                                margin: EdgeInsets.all(5.sp),
                                padding: EdgeInsets.all(5.sp),
                                child: Image.asset(
                                  "assets/icons/tips.png",
                                  width: 20.w,
                                  height: 20.h,
                                  color: const Color(0xff246DFF),
                                ),
                              ),
                            ),
                          ],
                        ),

                        Container(
                          padding: EdgeInsets.only(
                            left: 20.w,
                            top: 5.h,
                            bottom: 5.h,
                          ),
                          margin: EdgeInsets.only(
                            top: 12.h,
                          ),
                          width: double.maxFinite,
                          decoration: ShapeDecoration(
                            color: const Color(0xFF1B1927),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  width: 0.20.w, color: Colors.white),
                              borderRadius: BorderRadius.circular(15.r),
                            ),
                          ),
                          child: Opacity(
                            opacity: 0.81,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              maxLines: 1,
                              decoration: const InputDecoration(
                                isDense: true,
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              controller: seedController,
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                              ),
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
