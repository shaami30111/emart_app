import 'package:ai_art_gen/Utils/common_functions.dart';
import 'package:ai_art_gen/main.dart';
import 'package:ai_art_gen/provider/selection_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../constants/color_constants.dart';

class HistorySheet extends StatefulWidget {
  const HistorySheet({super.key});

  @override
  State<HistorySheet> createState() => _HistorySheetState();
}

class _HistorySheetState extends State<HistorySheet> {
  double sheetSize = 0.0;

  final historyController = DraggableScrollableController();

  @override
  void dispose() {
    historyController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    historyController.addListener(() {
      if (historyController.isAttached) {
        sheetSize = historyController.size;
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    rebuildAllChildren(context);
    return DraggableScrollableSheet(
      initialChildSize: 0.55,
      expand: false,
      controller: historyController,
      builder: (context, scrollController) {
        return Consumer<SelectionProvider>(
          builder: (context, value, child) {
            return SingleChildScrollView(
              controller: scrollController,
              child: Container(
                padding: EdgeInsets.only(
                  top: 30.h,
                  bottom: 10.h,
                ),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
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
                      height: 40.h,
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
                                  margin: EdgeInsets.only(
                                    left: 40.w,
                                  ),
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
                          'Prompt History',
                          style: TextStyle(
                            fontSize: 23.sp,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1.61,
                          ),
                        ),
                        sheetSize == 1.0
                            ? Container(
                                width: 5.w,
                                margin: EdgeInsets.only(
                                  right: 50.w,
                                ),
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    Divider(
                      thickness: 1.w,
                    ),
                    FutureBuilder(
                      future: db?.getAllPromptHistory(),
                      builder: (context, snapshot) {
                        return Visibility(
                          visible: snapshot.data?.isNotEmpty == true,
                          replacement: Center(
                            child: Column(
                              children: [
                                LottieBuilder.asset(
                                  "assets/icons/No history found.json",
                                ),
                                Text(
                                  'No history found!',
                                  style: TextStyle(
                                    fontSize: 22.sp,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 1.54,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          child: StatefulBuilder(
                            builder: (contextB, changeState) {
                              return Column(
                                children: [
                                  SizedBox(
                                    height:
                                        MediaQuery.of(contextB).size.height *
                                            .8,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: snapshot.data!.length,
                                      itemBuilder: (context, i) {
                                        return Container(
                                          margin: EdgeInsets.only(
                                            top: 30.h,
                                            bottom: 25.h,
                                            right: 40.w,
                                            left: 40.w,
                                          ),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15.r)),
                                          child: Stack(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.only(
                                                  top: 65.h,
                                                  bottom: 20.h,
                                                  right: 20.w,
                                                  left: 20.w,
                                                ),
                                                width: double.maxFinite,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.r),
                                                  border: Border.all(
                                                    color: white,
                                                    width: 0.20.w,
                                                  ),
                                                ),
                                                child: Opacity(
                                                  opacity: 0.80,
                                                  child: Text(
                                                    snapshot.data![i].prompt
                                                        .toString(),
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      fontSize: 15.sp,
                                                      fontFamily: 'Poppins',
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      height: 4.h,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                padding: EdgeInsets.only(
                                                  top: 12.h,
                                                  bottom: 12.h,
                                                  left: 20.w,
                                                  right: 10.w,
                                                ),
                                                decoration: ShapeDecoration(
                                                  color:
                                                      const Color(0xFF302F3D),
                                                  shape: RoundedRectangleBorder(
                                                    side: BorderSide(
                                                      width: 0.20.w,
                                                      color: const Color(
                                                          0xFF101739),
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(15.r),
                                                      topRight:
                                                          Radius.circular(15.r),
                                                    ),
                                                  ),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      calculateTimeC(snapshot
                                                          .data![i].created),
                                                      style: TextStyle(
                                                        fontSize: 15.sp,
                                                        fontFamily: 'Poppins',
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () async {
                                                            await Clipboard.setData(
                                                                ClipboardData(
                                                                    text: snapshot
                                                                        .data![
                                                                            i]
                                                                        .prompt
                                                                        .toString()));
                                                            Fluttertoast
                                                                .showToast(
                                                              msg:
                                                                  "Copied Prompt to clipboard!",
                                                              backgroundColor:
                                                                  iconColor
                                                                      .withOpacity(
                                                                          0.8),
                                                            );
                                                          },
                                                          child: Container(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    7.sp),
                                                            decoration:
                                                                const BoxDecoration(
                                                              color: Color(
                                                                  0xFF292834),
                                                              shape: BoxShape
                                                                  .circle,
                                                            ),
                                                            child: Image.asset(
                                                              "assets/icons/copy.png",
                                                              width: 25.w,
                                                              height: 25.h,
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 10.w,
                                                        ),
                                                        GestureDetector(
                                                          onTap: () async {
                                                            setState(() {
                                                              db?.deletePromptHistory(
                                                                  snapshot
                                                                      .data![i]
                                                                      .prompt);
                                                            });
                                                          },
                                                          child: Container(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    7.sp),
                                                            decoration:
                                                                const BoxDecoration(
                                                              color: Color(
                                                                  0xFF292834),
                                                              shape: BoxShape
                                                                  .circle,
                                                            ),
                                                            child: Image.asset(
                                                              "assets/creation/delete.png",
                                                              width: 25.w,
                                                              height: 25.h,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  )
                                ],
                              );
                            },
                          ),
                        );
                      },
                    ),
                    const Spacer(),
                    sheetSize == 1.0
                        ? Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              width: 115.w,
                              height: 10.h,
                              decoration: ShapeDecoration(
                                color: const Color(0xFF808080),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(3.r),
                                ),
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                    SizedBox(
                      height: 20.h,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
