import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class GradientButton extends StatelessWidget {
  Widget? icon;
  Widget? btntext;
  VoidCallback? onTap;
  Decoration? decoration;
  var height;
  var width;

  GradientButton({
    super.key,
    this.icon,
    this.btntext,
    this.onTap,
    this.decoration,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        padding: EdgeInsets.only(
            // top: 5.5.h,
            // left: 9.8.w,
            // right: 16.w
            ),
        decoration: decoration,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: btntext!,
            ),
            SizedBox(
              width: 5.w,
            ),
            icon!,
          ],
        ),
      ),
    );
  }
}
