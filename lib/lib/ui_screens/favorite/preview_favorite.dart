import 'dart:math';

import 'package:ai_art_gen/database/database.dart';
import 'package:ai_art_gen/reuableWidget/ad_container.dart';
import 'package:ai_art_gen/reuableWidget/gradient_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:drift/drift.dart' as drift;
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../../constants/color_constants.dart';
import '../../main.dart';
import '../../provider/selection_provider.dart';
import '../../reuableWidget/buildappBar.dart';

class PreviewFavorite extends StatefulWidget {
  InspirationFavoriteData data;

  PreviewFavorite({super.key, required this.data});

  @override
  State<PreviewFavorite> createState() => _PreviewFavoriteState();
}

class _PreviewFavoriteState extends State<PreviewFavorite> {
  bool removeF = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        "Favorites",
        context,
        isCenter: true,
        showLeading: true,
        action: [
          IconButton(
            onPressed: () {
              ////fav UnFav here
              var pro = Provider.of<SelectionProvider>(context, listen: false);
              pro.inspirIndex(widget.data);
              if (pro.inspirations[pro.inpIndex!].isFavorite!) {
                print("before delete");
                db?.deleteInspiration(widget.data.path);
                print("after delete");
                pro.removeInspir(widget.data);
                setState(() {
                  removeF = true;
                });
                Provider.of<SelectionProvider>(context, listen: false)
                    .fetchFavInspiration();
              } else {
                InspirationFavoriteCompanion model =
                    InspirationFavoriteCompanion(
                        id: drift.Value(Random().nextInt(100)),
                        path: drift.Value(widget.data.path),
                        command: drift.Value(widget.data.command),
                        proUserAccess: drift.Value(widget.data.proUserAccess),
                        isFavorite: const drift.Value(true));
                db?.saveInspiration(model);
                pro.addInspir(widget.data);
                setState(() {
                  removeF = false;
                });
                Provider.of<SelectionProvider>(context, listen: false)
                    .fetchFavInspiration();
              }
            },
            icon: removeF
                ? Icon(
                    Icons.favorite_border,
                    size: 50.sp,
                  )
                : Icon(
                    Icons.favorite,
                    color: const Color(0xffFFCC00),
                    size: 40.sp,
                  ),
          )
        ],
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
                    ClipRRect(
                      borderRadius: BorderRadius.circular(40.r),
                      child: CachedNetworkImage(
                        width: 597.w,
                        height: 595.h,
                        fit: BoxFit.cover,
                        imageUrl: widget.data.path,
                        placeholder: (context, url) => SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child: Container(
                            decoration: BoxDecoration(
                              color: iconColor,
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            padding: EdgeInsets.only(
                              top: 10.h,
                              right: 10.w,
                              left: 10.w,
                              bottom: 10.h,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                LottieBuilder.asset(
                                  "assets/icons/Processing_Image.json",
                                  width: 85.w,
                                  height: 85.h,
                                ),
                              ],
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Text(
                      widget.data.command,
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
              GradientButton(
                width: 525.w,
                height: 65.h,
                btntext: Text(
                  'Try this',
                  style: TextStyle(
                    fontSize: 25.sp,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                decoration: ShapeDecoration(
                  gradient: gradientColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(33.r),
                  ),
                ),
                onTap: () {
                  Provider.of<SelectionProvider>(context, listen: false)
                      .setTryPrompt(widget.data.command);
                  finish(context);
                  finish(context);
                },
                icon: const SizedBox.shrink(),
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
