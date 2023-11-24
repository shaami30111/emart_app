import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../models/languageModel.dart';
import '../../reuableWidget/ad_container.dart';

// ignore: must_be_immutable
class LanguageBody extends StatelessWidget {
  int? indx;
  bool? isSetting;

  LanguageBody({super.key, this.indx, this.isSetting = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StatefulBuilder(
          builder: (context, chageState) {
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: languageModelList.length,
              itemBuilder: (context, index) {
                bool selected = indx == index ? true : false;
                bool notSelected = indx != index ? true : false;
                return GestureDetector(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            decoration: !selected
                                ? ShapeDecoration(
                                    shape: RoundedRectangleBorder(
                                      side: const BorderSide(
                                          width: 0.50, color: Colors.white),
                                      borderRadius: BorderRadius.circular(25.r),
                                    ),
                                  )
                                : ShapeDecoration(
                                    color: const Color(0xFF201F2D),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25.r),
                                    ),
                                  ),
                            margin: EdgeInsets.only(
                              bottom: 10.h,
                              right: 16.w,
                              left: 16.w,
                              top: 10.h,
                            ),
                            child: ListTile(
                              visualDensity: const VisualDensity(
                                  horizontal: 0, vertical: -1),
                              splashColor: Colors.black,
                              onTap: () {
                                indx = index;
                                chageState(() {});
                              },
                              // contentPadding: EdgeInsets.only(left: 30.w),
                              leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(2.w),
                                  child: Image.asset(
                                    languageModelList[index].image.toString(),
                                    width: 50.w,
                                    height: 50.w,
                                    fit: BoxFit.cover,
                                  )),
                              title: Row(
                                children: [
                                  Container(
                                    height: 60.h,
                                    width: 1.w,
                                    decoration: const BoxDecoration(
                                      color: white,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 25.w,
                                  ),
                                  Text(
                                    languageModelList[index].name!,
                                    style: TextStyle(
                                      fontSize: 25.sp,
                                      letterSpacing: 0.7,
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                              trailing: Container(
                                child: !notSelected
                                    ? Image.asset(
                                        "assets/selected_circle.png",
                                        width: 28.83.w,
                                        height: 25.h,
                                      )
                                    : Image.asset(
                                        "assets/empty_circle.png",
                                        width: 28.83.w,
                                        height: 25.h,
                                      ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
        // SizedBox(
        //   height: 66.h,
        // ),
        const Spacer(),
        const AddContainer(),
      ],
    );
  }
}
