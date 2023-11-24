import 'package:ai_art_gen/Utils/common_functions.dart';
import 'package:ai_art_gen/constants/color_constants.dart';
import 'package:ai_art_gen/provider/selection_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../../constants/text_constants.dart';

class PremiumDiscountScreen extends StatefulWidget {
  const PremiumDiscountScreen({super.key});

  @override
  State<PremiumDiscountScreen> createState() => _PremiumDiscountScreenState();
}

class _PremiumDiscountScreenState extends State<PremiumDiscountScreen> {
  List<String> discountPrice = [
    "9.00/week",
    "15.00/month",
    "11.00/month",
  ];
  List<String> type = [
    "Weekly",
    "Yearly",
    "Lifetime",
  ];
  List<String> rawPrice = [
    "18.00",
    "30.00",
    "100.00",
  ];

  Widget tick = Image.asset(
    "assets/icons/white_tick.png",
    width: 30.w,
    height: 30.h,
  );

  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/favorite/proVideo.mp4',
        videoPlayerOptions: VideoPlayerOptions(allowBackgroundPlayback: true))
      ..initialize().then((_) {
        _controller.play();
        _controller.setLooping(true);
        setState(() {}); //when your thumbnail will show.
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SelectionProvider>(
      builder: (context, value, child) => WillPopScope(
        onWillPop: () async {
          if (value.clickGen == 3) {
            value.resetDiscount();
            value.resetClick();
            value.initialize();
            finish(context);
          }
          return false;
        },
        child: SafeArea(
          child: Scaffold(
            body: Consumer<SelectionProvider>(
              builder: (context, value, child) {
                return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 680.h,
                        child: Stack(
                          children: [
                            SizedBox(
                              height: 680.h,
                              // decoration: BoxDecoration(
                              //   // border: Border.all(width: 1.w),
                              // ),
                              child: _controller.value.isInitialized
                                  ?
                                  // LoopingVideoWidget(videoUrl: widget.videoUrl)
                                  VideoPlayer(
                                      _controller,
                                    )
                                  : Center(
                                      child: LottieBuilder.asset(
                                          "assets/icons/Processing_Image.json"),
                                    ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                color: Theme.of(context).colorScheme.background,
                                height: 130.h,
                                width: double.maxFinite,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    '50% Off',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: const Color(0xFFFFC400),
                                      fontSize: 100.sp,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w400,
                                      height: 0.01.h,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Subscription Plan',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 22.sp,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      // SizedBox(
                      //   width: double.maxFinite,
                      //   child: Stack(
                      //     children: [
                      //       Align(
                      //         alignment: Alignment.center,
                      //         child: Text(
                      //           "\$${discountPrice[1]}",
                      //           textAlign: TextAlign.center,
                      //           style: TextStyle(
                      //             fontSize: 40.sp,
                      //             fontFamily: 'Poppins',
                      //             fontWeight: FontWeight.w500,
                      //           ),
                      //         ),
                      //       ),
                      //       Positioned(
                      //         top: 12.h,
                      //         left: 180.w,
                      //         child: Opacity(
                      //           opacity: 0.50,
                      //           child: Text(
                      //             '\$18.00',
                      //             textAlign: TextAlign.center,
                      //             style: TextStyle(
                      //               fontSize: 20.sp,
                      //               fontFamily: 'Poppins',
                      //               fontWeight: FontWeight.w500,
                      //               decoration: TextDecoration.lineThrough,
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 170.w,
                          ),
                          SizedBox(
                            child: Opacity(
                              opacity: 0.50,
                              child: Text(
                                '\$${rawPrice[value.proSelection]}',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "\$${discountPrice[value.proSelection]}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 40.sp,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 60.h,
                      ),
                      Container(
                        width: 615.w,
                        height: 100.h,
                        padding: EdgeInsets.only(
                          top: 5.h,
                          bottom: 5.h,
                          left: 5.w,
                          right: 5.w,
                        ),
                        decoration: ShapeDecoration(
                          color: iconColor,
                          shape: RoundedRectangleBorder(
                            side:
                                BorderSide(width: 0.10.w, color: Colors.white),
                            borderRadius: BorderRadius.circular(40.r),
                          ),
                        ),
                        child: HorizontalList(
                          itemCount: type.length,
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                value.setType(index);
                              },
                              child: Container(
                                width: 190.w,
                                height: 90.h,
                                decoration: value.selection[index]
                                    ? ShapeDecoration(
                                        gradient: gradientColorT,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(40.r),
                                        ),
                                      )
                                    : null,
                                child: Center(
                                  child: Text(
                                    type[index],
                                    style: TextStyle(
                                      fontSize: 25.sp,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: EdgeInsets.only(
                          left: 65.w,
                          right: 165.w,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                tick,
                                SizedBox(
                                  width: 20.w,
                                ),
                                Text(
                                  'No daily limit',
                                  style: TextStyle(
                                    fontSize: 22.sp,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                tick,
                                SizedBox(
                                  width: 20.w,
                                ),
                                Text(
                                  'No Ads',
                                  style: TextStyle(
                                    fontSize: 22.sp,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          left: 65.w,
                          right: 84.w,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                tick,
                                SizedBox(
                                  width: 20.w,
                                ),
                                Text(
                                  'Faster Processing',
                                  style: TextStyle(
                                    fontSize: 22.sp,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                tick,
                                SizedBox(
                                  width: 20.w,
                                ),
                                Text(
                                  'HD Downloads',
                                  style: TextStyle(
                                    fontSize: 22.sp,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 115.w,
                        ),
                        // height: 90,
                        padding: EdgeInsets.only(
                          left: 150.w,
                          top: 25.h,
                          bottom: 20.h,
                          right: 150.w,
                        ),
                        decoration: ShapeDecoration(
                          gradient: gradientColorT,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                width: 0.5.w, color: const Color(0xFFC1C1C1)),
                            borderRadius: BorderRadius.circular(45.r),
                          ),
                        ),
                        child: Text(
                          'CONTINUE',
                          style: TextStyle(
                            fontSize: 30.sp,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        height: 35.h,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                openTermOfUseUrl(context);
                              },
                              child: Text(
                                'Terms of Use',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 0.48,
                                  height: 4.h,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 15.w,
                            ),
                            Container(
                              height: 20.h,
                              width: 1.w,
                              decoration: const BoxDecoration(
                                color: white,
                              ),
                            ),
                            SizedBox(
                              width: 15.w,
                            ),
                            GestureDetector(
                              onTap: () {
                                openPrivacyUrl(context);
                              },
                              child: Text(
                                'Privacy Policy',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 0.48,
                                  height: 4.h,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 15.w,
                            ),
                            Container(
                              height: 20.h,
                              width: 1.w,
                              decoration: const BoxDecoration(
                                color: white,
                              ),
                            ),
                            SizedBox(
                              width: 15.w,
                            ),
                            GestureDetector(
                              onTap: () {
                                openRestoreUrl(context);
                              },
                              child: Text(
                                'Restore',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 0.48,
                                  height: 4.h,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
