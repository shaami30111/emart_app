import 'dart:convert';
import 'dart:io';

import 'package:ai_art_gen/provider/selection_provider.dart';
import 'package:ai_art_gen/reuableWidget/buildappBar.dart';
import 'package:ai_art_gen/reuableWidget/button.dart';
import 'package:ai_art_gen/reuableWidget/dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../../Utils/common_functions.dart';
import '../../constants/api_end_points_constants.dart';
import '../../constants/color_constants.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  int selected = 0;
  var isMoreSelected = false;
  var savedCacheImagePath = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Provider.of<SelectionProvider>(context, listen: false)
            .clearGeneratedMore();
        discardDialog(context);
        return false;
      },
      child: Scaffold(
        appBar: appBar(
          "Result",
          context,
          isCenter: true,
          showLeading: true,
          noBack: true,
          onTap: () async {
            Provider.of<SelectionProvider>(context, listen: false)
                .clearGeneratedMore();
            discardDialog(context);
          },
          action: [
            GestureDetector(
              onTap: () {
                saveImageSheet(context);
              },
              child: Container(
                padding: EdgeInsets.all(1.sp),
                child: LottieBuilder.asset(
                  "assets/icons/Dwonload.json",
                  width: 52.w,
                  height: 52.h,
                ),
              ),
            ),
            SizedBox(
              width: 30.w,
            )
          ],
        ),
        body: Padding(
          padding: EdgeInsets.only(
            left: 40.w,
            right: 40.w,
            top: 30.h,
            bottom: 20.h,
          ),
          child: Consumer<SelectionProvider>(
            builder: (context, value, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.50,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.r),
                      child: Image.file(
                        File(value.generatePreview),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  value.generatedMore.isNotEmpty
                      ? HorizontalList(
                          itemCount: value.generatedMore.length,
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                selected = index;
                                value.generatePreview =
                                    value.generatedMore[index];
                                setState(() {
                                  savedCacheImagePath =
                                      value.generatedMore[index];
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(20.r),
                                      child: Image.file(
                                        File(value.generatedMore[index]),
                                        width: 130.w,
                                        height: 130.h,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    selected == index
                                        ? Container(
                                            width: 130.w,
                                            height: 130.h,
                                            decoration: BoxDecoration(
                                              color: Colors.black.withOpacity(
                                                  0.3803921639919281),
                                              borderRadius:
                                                  BorderRadius.circular(20.r),
                                            ),
                                            child: Icon(
                                              Icons.check,
                                              size: 40.sp,
                                            ),
                                          )
                                        : const SizedBox.shrink(),
                                  ],
                                ),
                              ),
                            );
                          },
                        )
                      : const SizedBox.shrink(),
                  SizedBox(
                    height: 30.h,
                  ),
                  // buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      smallButton(
                        onTap: () {
                          // generateVariantSheet(
                          //     context, "Generating similar variants ");
                          // saveImageSheet(context);
                        },
                        icon: Image.asset(
                          "assets/icons/box.png",
                          height: 25.h,
                          width: 25.w,
                        ),
                        btntext: Text(
                          'Generate Variant',
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
                          left: 30.w,
                          right: 30.w,
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
                      SizedBox(
                        width: 20.w,
                      ),
                      smallButton(
                        onTap: () async {
                          value.addDialog("AI Analysis Prompt");
                          // ignore: use_build_context_synchronously
                          generateDialog(
                            context,
                            LottieBuilder.asset(
                                "assets/icons/AI_Processing.json"),
                          );

                          ///----Here i will clear previously generated list Api Call
                          Provider.of<SelectionProvider>(context, listen: false)
                              .clearGeneratedMore();
                          bool isApiCall = await generateImageWithDio(
                              value.generatePrompt, value);

                          if (isApiCall) {
                            if (kDebugMode) {
                              print(
                                  "objectFirstImagePath--->${value.generatedMore[0]}");
                            }
                            setState(() {
                              selected = 0;
                            });
                            // ignore: use_build_context_synchronously
                            Navigator.pop(context);
                            value.generatePreview = value.generatedMore[0];
                          }
                        },
                        icon: Image.asset(
                          "assets/icons/add.png",
                          height: 25.h,
                          width: 25.w,
                        ),
                        padding: EdgeInsets.only(
                          top: 20.h,
                          bottom: 20.h,
                          left: 30.w,
                          right: 30.w,
                        ),
                        btntext: Text(
                          'Generate More',
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.60,
                          ),
                        ),
                        decoration: BoxDecoration(
                          gradient: gradientColor,
                          borderRadius: BorderRadius.circular(40.r),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  Stack(
                    children: [
                      Container(
                        width: double.maxFinite,
                        padding: EdgeInsets.only(
                          top: 25.h,
                          left: 20.w,
                          right: 50.w,
                          bottom: 30.h,
                        ),
                        decoration: BoxDecoration(
                          color: iconColor,
                          borderRadius: BorderRadius.circular(15.r),
                          border: Border.all(
                            width: 0.20.w,
                            color: Colors.white,
                          ),
                        ),
                        child: Opacity(
                          opacity: 0.95,
                          child: Text(
                            value.promptMain,
                            maxLines: 4,
                            style: TextStyle(
                                fontSize: 16.sp,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                                overflow: TextOverflow.ellipsis),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: GestureDetector(
                          onTap: () {
                            resultSheet(context, value.promptMain);
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                              top: 18.h,
                              right: 15.w,
                              bottom: 18.h,
                              left: 15.w,
                            ),
                            padding: EdgeInsets.only(
                              top: 5.h,
                              bottom: 7.h,
                              left: 7.w,
                              right: 7.w,
                            ),
                            decoration: const BoxDecoration(
                              color: Color(0xFF444350),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.edit,
                              size: 25.sp,
                              color: complColor,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Future<bool> generateImageWithDio(String prompt, SelectionProvider value,
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
      "batch_size": batchSize,
      "cfg_scale": cfgScale
    };
    try {
      final dio = Dio();
      final response = await dio.post(
        '$url/sdapi/v1/txt2img',
        data: json.encode(payload),
        options: Options(
          contentType: Headers.jsonContentType,
        ),
      );
      if (response.statusCode == 200) {
        final r = response.data;
        if (kDebugMode) {
          print("JsonObjectCount${r['images'].length}");
        }
        bool deletionResult = await _deleteTemporaryFiles();
        print("sadasds--->$deletionResult");
        if (deletionResult) {
          final Directory tempDir = await getTemporaryDirectory();
          final String childDirPath =
              '${tempDir.path}/$photoGalleryChildDirectoryPath';
          final Directory childDir = Directory(childDirPath);
          await childDir.create(recursive: true);
          for (var index = 0; index < r['images'].length; index++) {
            final imageBase64 = r['images'][index].split(",").last;
            final imageBytes = base64Decode(imageBase64);
            final currentTimeInMilliseconds =
                DateTime.now().millisecondsSinceEpoch;
            final imagePath =
                '${childDir.path}/output_$currentTimeInMilliseconds.png';
            final File tempFile = File(imagePath);
            await tempFile.writeAsBytes(imageBytes);
            value.addGeneratedMore(imagePath);
            if (kDebugMode) {
              print('Image saved to $imagePath');
            }
          }
          return true;
        }
      } else {
        if (kDebugMode) {
          print('Failed to get the image. Status code: ${response.statusCode}');
        }
        return false;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error during image generation: $e');
      }
      return false;
    }
    return false;
  }

  Future<bool> _deleteTemporaryFiles() async {
    try {
      final Directory tempDir = await getTemporaryDirectory();
      final String childDirPath =
          '${tempDir.path}/$photoGalleryChildDirectoryPath';
      final Directory childDir = Directory(childDirPath);
      await childDir.create(recursive: true);
      if (await childDir.exists()) {
        await for (var entity in childDir.list()) {
          if (entity is File) {
            await entity.delete();
          }
        }
        return true;
      } else {
        return true;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error deleting files: $e');
      }
      return false; // Deletion failed
    }
  }
}
