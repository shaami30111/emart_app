import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nb_utils/nb_utils.dart';

appBar(title, context,
    {action,
    isCenter = false,
    showLeading = false,
    leading,
    noBack = false,
    fontWeight,
    onTap}) {
  return AppBar(
    automaticallyImplyLeading: false,
    leading: showLeading == true
        ? IconButton(
            onPressed: noBack == true
                ? onTap
                : () {
                    finish(context);
                  },
            icon: Icon(
              Icons.arrow_back_ios,
              size: 30.sp,
            ),
          )
        : const SizedBox.shrink(),
    centerTitle: isCenter,
    title: Text(
      title,
      style: TextStyle(
        fontSize: 28.sp,
        fontFamily: "Poppins",
        fontWeight: fontWeight ?? FontWeight.w600,
        letterSpacing: 0.9,
      ),
    ),
    actions: action,
    elevation: 0,
    // backgroundColor: iconColor,
  );
}
