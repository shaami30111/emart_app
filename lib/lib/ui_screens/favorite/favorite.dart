import 'package:ai_art_gen/constants/color_constants.dart';
import 'package:ai_art_gen/provider/selection_provider.dart';
import 'package:ai_art_gen/reuableWidget/buildappBar.dart';
import 'package:ai_art_gen/ui_screens/favorite/preview_favorite.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class Favorite extends StatefulWidget {
  const Favorite({super.key});

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    Provider.of<SelectionProvider>(context, listen: false)
        .fetchFavInspiration();
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SelectionProvider>(
      builder: (context, value, child) => Scaffold(
        appBar: appBar(
          "Favorites",
          context,
          isCenter: true,
          showLeading: true,
        ),
        body: isLoading
            ? Center(
                child: LottieBuilder.asset(
                  "assets/icons/Processing_Image.json",
                  width: 150.w,
                  height: 150.h,
                ),
              )
            : value.favInspirations.isEmpty
                ? Center(
                    child: Opacity(
                      opacity: 0.60,
                      child: Text(
                        'Not favorite is added yet!',
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
                      bottom: 20.h,
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
                          mainAxisExtent: 300.h,
                          // childAspectRatio: 1,
                        ),
                        itemCount: value.favInspirations.length,
                        scrollDirection: Axis.vertical,
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              PreviewFavorite(
                                      data: value.favInspirations[index])
                                  .launch(context);
                            },
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    width: 302.w,
                                    height: 292.h,
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
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(40.r),
                                      child: CachedNetworkImage(
                                        width: 597.w,
                                        height: 595.h,
                                        fit: BoxFit.cover,
                                        imageUrl:
                                            value.favInspirations[index].path,
                                        // value.favStyle[index].thumb.toString(),
                                        placeholder: (context, url) => SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: MediaQuery.of(context)
                                              .size
                                              .height,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: iconColor,
                                              borderRadius:
                                                  BorderRadius.circular(20.r),
                                            ),
                                            padding: EdgeInsets.only(
                                              top: 10.h,
                                              right: 10.w,
                                              left: 10.w,
                                              bottom: 10.h,
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
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
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    width: 300.w,
                                    // height: 60.h,
                                    padding: EdgeInsets.only(
                                      top: 18.h,
                                      left: 17.w,
                                      bottom: 18.h,
                                      right: 30.w,
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
                                      value.favInspirations[index].command
                                                  .length >
                                              100
                                          ? '${value.favInspirations[index].command.substring(0, 30)}...'
                                          : value
                                              .favInspirations[index].command,
                                      // overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Container(
                                    margin: EdgeInsets.only(
                                      right: 13.w,
                                      bottom: 13.h,
                                    ),
                                    child: Icon(
                                      Icons.favorite,
                                      color: const Color(0xffFFCC00),
                                      size: 38.sp,
                                    ),
                                  ),
                                )
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
