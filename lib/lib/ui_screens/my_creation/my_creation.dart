import 'dart:io';

import 'package:ai_art_gen/constants/color_constants.dart';
import 'package:ai_art_gen/models/image_model.dart';
import 'package:ai_art_gen/reuableWidget/buildappBar.dart';
import 'package:ai_art_gen/ui_screens/my_creation/preview_creation.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../../database/database.dart';
import '../../main.dart';
import '../../provider/selection_provider.dart';

class MyCreation extends StatefulWidget {
  const MyCreation({super.key});

  @override
  State<MyCreation> createState() => _MyCreationState();
}

class _MyCreationState extends State<MyCreation> {
  @override
  void initState() {
    super.initState();
    fetchDbData();
  }

  Future<void> fetchDbData() async {
    final List<MyCreationData>? creations = await db?.getAllCreations();
    debugPrint("CreationLength${creations?.length}");
    if (creations?.isNotEmpty == true) {
      for (var creation in creations!) {
        if (kDebugMode) {
          print(
              'IDasdasds: ${creation.id}, ImagePath: ${creation.imagePath}, Description: ${creation.description}, Is Favorite: ${creation.isFavorite}');
        }
      }
    }
  }

  @override
  void didChangeDependencies() {
    Provider.of<SelectionProvider>(context, listen: false)
        .fetchAllCreatedFiles();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        appBar: appBar(
          "My Creation",
          context,
          isCenter: true,
          showLeading: true,
        ),
        body: Consumer<SelectionProvider>(
          builder: (context, value, child) {
            return value.myCreations.isEmpty
                ? Center(
                    child: Opacity(
                      opacity: 0.60,
                      child: Text(
                        'Not result found!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 25.sp,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.75,
                        ),
                      ),
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.only(
                      left: 45.w,
                      right: 45.w,
                      top: 15.h,
                      bottom: 45.h,
                    ),
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width,
                        maxHeight: MediaQuery.of(context).size.height,
                      ),
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // Number of columns
                          crossAxisSpacing: 20.w,
                          mainAxisSpacing: 25.h,
                          mainAxisExtent: 270.h,
                          // childAspectRatio: 1,
                        ),
                        itemCount: value.myCreations.length,
                        scrollDirection: Axis.vertical,
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              PreviewCreation(data: value.myCreations[index])
                                  .launch(context);
                            },
                            child: Container(
                              // width: 300.w,
                              // height: 295.h,
                              decoration: ShapeDecoration(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40.r),
                                ),
                                shadows: [
                                  BoxShadow(
                                    color: const Color(0x29000000),
                                    blurRadius: 5.r,
                                    offset: const Offset(6, 6),
                                    spreadRadius: 0,
                                  )
                                ],
                              ),
                              child: Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Container(
                                      width: 302.w,
                                      height: 295.h,
                                      decoration: ShapeDecoration(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(40.r),
                                        ),
                                        shadows: [
                                          BoxShadow(
                                            color: const Color(0x29000000),
                                            blurRadius: 5.r,
                                            offset: const Offset(6, 6),
                                            spreadRadius: 0,
                                          )
                                        ],
                                      ),
                                      child: Container(
                                        width: 110.w,
                                        height: 110.h,
                                        decoration: ShapeDecoration(
                                          image: DecorationImage(
                                            image: Image.file(
                                              File(value.myCreations[index]
                                                      .imagePath ??
                                                  ""),
                                            ).image,
                                            fit: BoxFit.cover,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.r),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Container(
                                      width: 300.w,
                                      // height: 70.h,
                                      padding: EdgeInsets.only(
                                        top: 8.h,
                                        left: 20.w,
                                        bottom: 8.h,
                                        right: 15.w,
                                      ),
                                      decoration: ShapeDecoration(
                                        gradient: lineGradientColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(40.r),
                                            bottomRight: Radius.circular(40.r),
                                          ),
                                        ),
                                        shadows: [
                                          BoxShadow(
                                            color: const Color(0x29000000),
                                            blurRadius: 5.r,
                                            offset: const Offset(6, 6),
                                            spreadRadius: 0,
                                          )
                                        ],
                                      ),
                                      child: Text(
                                        value.myCreations[index].description!
                                                    .length >
                                                200
                                            ? '${value.myCreations[index].description!.substring(0, 50)}...'
                                            : value.myCreations[index]
                                                .description!,
                                        // overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
          },
        ),
      ),
    );
  }
}
