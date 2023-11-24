import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../../constants/color_constants.dart';
import '../../provider/selection_provider.dart';

class ProPackage extends StatefulWidget {
  String price;
  String discount;
  String type;
  int index;

  ProPackage({
    super.key,
    required this.price,
    required this.discount,
    required this.type,
    required this.index,
  });

  @override
  State<ProPackage> createState() => _ProPackageState();
}

class _ProPackageState extends State<ProPackage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SelectionProvider>(
      builder: (context, value, child) {
        return Column(
          children: [
            widget.index == 1
                ? Opacity(
                    opacity: value.selection[1] ? 1 : 0.53,
                    child: SizedBox(
                      width: 225.w,
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Image.asset(
                              "assets/icons/bubble.png",
                              width: value.selection[1] ? 225.w : 193.w,
                              height: value.selection[1] ? 85.h : 64.h,
                              color: value.selection[1]
                                  ? null
                                  : const Color(0xFF101739),
                            ),
                          ),
                          // Container(
                          //   padding: EdgeInsets.only(
                          //     left: 26.w,
                          //     top: 15.h,
                          //     bottom: 25.h,
                          //     right: 25.w,
                          //   ),
                          //   child: Text(
                          //     'MOST POPULAR',
                          //     style: TextStyle(
                          //       fontSize: value.selection[1] ? 24.h : 20.h,
                          //       fontFamily: 'Poppins',
                          //       fontWeight: value.selection[1]
                          //           ? FontWeight.w500
                          //           : FontWeight.w300,
                          //     ),
                          //   ),
                          // ),
                          Center(
                            child: Container(
                              padding: EdgeInsets.only(
                                top: 13.h,
                              ),
                              child: Text(
                                'MOST POPULAR',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: value.selection[1] ? 24.h : 20.h,
                                  fontFamily: 'Poppins',
                                  fontWeight: value.selection[1]
                                      ? FontWeight.w500
                                      : FontWeight.w300,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
            GestureDetector(
              onTap: () {
                value.setType(widget.index);
              },
              child: Container(
                // width: value.selection[widget.index] ? 227.w : 195.w,
                // height: value.selection[widget.index] ? 255.h : 215.h,
                padding: EdgeInsets.only(
                  left: 5.w,
                  right: 5.w,
                  bottom: 5.h,
                  top: value.selection[widget.index] ? 20.h : 15.h,
                ),
                // margin: EdgeInsets.only(
                // right: 12.w,
                // left: 25.w,
                //     ),
                decoration: ShapeDecoration(
                  gradient: value.selection[widget.index]
                      ? gradientColorT
                      : gradientColorUn,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.r),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Opacity(
                      opacity: value.selection[widget.index] ? 1 : 0.45,
                      child: Text(
                        '\$ ${widget.price}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize:
                              value.selection[widget.index] ? 25.sp : 20.sp,
                          fontFamily: 'Poppins',
                          fontWeight: value.selection[widget.index]
                              ? FontWeight.w500
                              : FontWeight.w300,
                          letterSpacing: 0.69,
                        ),
                      ),
                    ),
                    Opacity(
                      opacity: value.selection[widget.index] ? 1 : 0.45,
                      child: Container(
                        width: value.selection[widget.index] ? 216.w : 185.w,
                        height: value.selection[widget.index] ? 180.h : 160.h,
                        padding: EdgeInsets.only(
                          right: 5.w,
                          left: 5.w,
                          top: value.selection[widget.index] ? 32.h : 28.h,
                          bottom: value.selection[widget.index] ? 15.h : 14.h,
                        ),
                        margin: EdgeInsets.only(
                          top: 5.h,
                        ),
                        decoration: ShapeDecoration(
                          color: const Color(0xFFEEEEEE),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10.r),
                              bottomRight: Radius.circular(10.r),
                            ),
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              widget.type,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: value.selection[widget.index]
                                    ? const Color(0xFF101739)
                                    : grey.withOpacity(0.5),
                                fontSize: value.selection[widget.index]
                                    ? 45.sp
                                    : 35.sp,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const Spacer(),
                            // SizedBox(
                            //   height:
                            //       value.selection[widget.index] ? 20.h : 30.h,
                            // ),
                            Text(
                              'SAVE ${widget.discount}',
                              style: TextStyle(
                                color: value.selection[widget.index]
                                    ? Colors.black
                                    : grey.withOpacity(0.5),
                                fontSize: value.selection[widget.index]
                                    ? 18.sp
                                    : 15.sp,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w300,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
