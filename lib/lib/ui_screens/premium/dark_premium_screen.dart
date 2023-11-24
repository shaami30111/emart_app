import 'package:ai_art_gen/Utils/common_functions.dart';
import 'package:ai_art_gen/constants/color_constants.dart';
import 'package:ai_art_gen/provider/selection_provider.dart';
import 'package:ai_art_gen/ui_screens/premium/package.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../../constants/text_constants.dart';

class PremiumScreen extends StatefulWidget {
  const PremiumScreen({super.key});

  @override
  State<PremiumScreen> createState() => _PremiumScreenState();
}

class _PremiumScreenState extends State<PremiumScreen> {
  List<String> price = [
    "9.00/week",
    "15.00/month",
    "11.00/month",
  ];
  List<String> type = [
    "Weekly",
    "Yearly",
    "Lifetime",
  ];
  List<String> discount = [
    "10%",
    "20%",
    "40%",
  ];

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
    return WillPopScope(
      onWillPop: () async {
        Provider.of<SelectionProvider>(context, listen: false).initialize();
        finish(context);

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
                      height: 688.h,
                      // decoration: BoxDecoration(
                      //   // border: Border.all(width: 1.w),
                      // ),
                      child: Stack(
                        children: [
                          SizedBox(
                            height: 680.33.h,
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
                            child: Image.asset(
                              "assets/cutting.png",
                              // color: white,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 380.h,
                      child: HorizontalList(
                        crossAxisAlignment: WrapCrossAlignment.end,
                        itemCount: price.length,
                        itemBuilder: (context, index) {
                          return ProPackage(
                            price: price[index],
                            discount: discount[index],
                            type: type[index],
                            index: index,
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
                              Image.asset(
                                "assets/icons/check_tick.png",
                                width: 30.w,
                                height: 30.h,
                              ),
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
                              Image.asset(
                                "assets/icons/check_tick.png",
                                width: 30.w,
                                height: 30.h,
                              ),
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
                              Image.asset(
                                "assets/icons/check_tick.png",
                                width: 30.w,
                                height: 30.h,
                              ),
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
                              Image.asset(
                                "assets/icons/check_tick.png",
                                width: 30.w,
                                height: 30.h,
                              ),
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
                    Container(
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
    );
  }
}
