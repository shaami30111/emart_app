import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../constants/color_constants.dart';
import '../../reuableWidget/buildappBar.dart';
import '../intro_screen.dart';
import 'language_body.dart';

// ignore: must_be_immutable
class LanguageScreen extends StatelessWidget {
  bool? isSetting;

  LanguageScreen({super.key, this.isSetting = false});

  int indx = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (isSetting!) {
          return true;
        }
        return false;
      },
      child: Scaffold(
        appBar: appBar(
          "Choose Language",
          context,
          isCenter: true,
          action: [
            GestureDetector(
              onTap: () {
                isSetting!
                    ? finish(context)
                    : const IntroScreen().launch(context, isNewTask: true);
              },
              child: Container(
                width: 60.w,
                height: 35.h,
                padding: EdgeInsets.only(
                  left: 17.w,
                  right: 17.w,
                ),
                decoration: ShapeDecoration(
                  gradient: gradientColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(33.r),
                  ),
                ),
                child: Center(
                  child: Image.asset(
                    "assets/icons/tick.png",
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 40.w,
            ),
          ],
        ),
        body: MediaQuery.of(context).orientation == Orientation.portrait
            ? LanguageBody(
                indx: indx,
                isSetting: isSetting,
              )
            : SingleChildScrollView(
                child: LanguageBody(
                  indx: indx,
                  isSetting: isSetting,
                ),
              ),
      ),
    );
  }
}
