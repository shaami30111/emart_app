// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:ai_art_gen/models/image_model.dart';
import 'package:ai_art_gen/reuableWidget/ad_container.dart';
import 'package:ai_art_gen/reuableWidget/dialog.dart';
import 'package:ai_art_gen/reuableWidget/share_sheet.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import '../../Utils/common_functions.dart';
import '../../constants/color_constants.dart';
import '../../provider/selection_provider.dart';
import '../../reuableWidget/buildappBar.dart';

// ignore: must_be_immutable
class PreviewCreation extends StatefulWidget {
  ImageModel data;

  PreviewCreation({super.key, required this.data});

  @override
  State<PreviewCreation> createState() => _PreviewCreationState();
}

class _PreviewCreationState extends State<PreviewCreation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        "My Creation",
        context,
        isCenter: true,
        showLeading: true,
      ),
      body: Padding(
        padding: EdgeInsets.only(
          top: 20.h,
          left: 40.w,
          right: 40.w,
          bottom: 20.h,
        ),
        child: Center(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(
                  top: 25.h,
                  left: 22.w,
                  right: 22.w,
                  bottom: 30.h,
                ),
                decoration: ShapeDecoration(
                  color: iconColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 597.w,
                      height: 595.h,
                      decoration: ShapeDecoration(
                        image: DecorationImage(
                          image: Image.file(
                            File(widget.data.imagePath ?? ""),
                          ).image,
                          fit: BoxFit.cover,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.r),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Text(
                      widget.data.description!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 17.sp,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        height: 3.5.h,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 40.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // --Delete
                  GestureDetector(
                    onTap: () {
                      dialogModal(
                        context,
                        true,
                        "Are you sure you want to delete\nthe selected items?",
                        () async {
                          var result = await deleteImageFile(
                              File(widget.data.imagePath ?? "").path);
                          if (kDebugMode) {
                            print("objectDeletyResult$result");
                          }
                          Provider.of<SelectionProvider>(context, listen: false)
                              .myCreations
                              .clear();
                          Provider.of<SelectionProvider>(context, listen: false)
                              .fetchAllCreatedFiles();
                          finish(context);
                          finish(context);
                          Fluttertoast.showToast(
                            msg: "Item Deletion Action",
                            backgroundColor: iconColor.withOpacity(0.8),
                          );
                        },
                        () {
                          Navigator.pop(context);
                        },
                        Text(
                          'Delete',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: const Color(0xFFFF4040),
                            fontSize: 20.sp,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            letterSpacing: 1.40,
                          ),
                        ),
                        Text(
                          'Cancel',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            letterSpacing: 1.40,
                          ),
                        ),
                        ShapeDecoration(
                          color: iconColor,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              width: 2.w,
                              color: const Color(0xFFFF4040),
                            ),
                            borderRadius: BorderRadius.circular(33.r),
                          ),
                        ),
                        ShapeDecoration(
                          color: iconColor,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(width: 2.w, color: Colors.white),
                            borderRadius: BorderRadius.circular(33.r),
                          ),
                        ),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                        top: 15.h,
                        left: 65.w,
                        right: 65.w,
                        bottom: 12.h,
                      ),
                      decoration: ShapeDecoration(
                        color: iconColor,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                              width: 2.w, color: const Color(0xFFFF4040)),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset("assets/creation/delete.png",
                              width: 20.w,
                              height: 25.h,
                              color: const Color(0xFFFF4040)),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                            'Delete',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color(0xFFFF4040),
                              fontSize: 23.sp,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.69,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 30.w,
                  ),
                  //  --Share
                  GestureDetector(
                    onTap: () {
                      shareSheet(context, widget.data.imagePath);
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                        top: 15.h,
                        left: 65.w,
                        right: 65.w,
                        bottom: 12.h,
                      ),
                      decoration: ShapeDecoration(
                        color: iconColor,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 2.w,
                            color: white,
                          ),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/creation/share.png",
                            width: 18.w,
                            height: 23.h,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                            'Share',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 23.sp,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.69,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              const AddContainer(),
            ],
          ),
        ),
      ),
    );
  }
}
