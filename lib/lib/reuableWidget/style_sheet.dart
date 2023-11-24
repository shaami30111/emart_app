import 'package:ai_art_gen/main.dart';
import 'package:ai_art_gen/models/image_model.dart';
import 'package:ai_art_gen/provider/selection_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:drift/drift.dart' as d;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../constants/color_constants.dart';
import '../database/database.dart';

class StyleSheet extends StatefulWidget {
  const StyleSheet({super.key});

  @override
  State<StyleSheet> createState() => _StyleSheetState();
}

class _StyleSheetState extends State<StyleSheet>
    with SingleTickerProviderStateMixin {
  bool isLoaded = true;
  bool newTab = false;
  late TabController _controller;
  int _selectedIndex = 0;
  double sheetSize = 0.0;

  final styleController = DraggableScrollableController();

  @override
  void dispose() {
    _controller.dispose();
    styleController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    styleController.addListener(() {
      if (styleController.isAttached) {
        sheetSize = styleController.size;
        setState(() {});
      }
    });
    // Create TabController for getting the index of current tab
    _controller = TabController(length: 2, vsync: this);

    _controller.addListener(() {
      setState(() {
        _selectedIndex = _controller.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.55,
      expand: false,
      controller: styleController,
      builder: (context, scrollController) {
        return Consumer<SelectionProvider>(
          builder: (context, value, child) {
            return SingleChildScrollView(
              controller: scrollController,
              child: Container(
                padding: EdgeInsets.only(
                  top: 30.h,
                  bottom: 10.h,
                ),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                // width: double.maxFinite,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50.r),
                    topRight: Radius.circular(50.r),
                  ),
                  color: btnTextColor,
                ),
                child: Column(
                  children: [
                    sheetSize == 1.0
                        ? SizedBox(
                            height: 30.h,
                          )
                        : const SizedBox.shrink(),
                    sheetSize == 1.0
                        ? const SizedBox.shrink()
                        : Container(
                            width: 115.w,
                            height: 10.h,
                            decoration: ShapeDecoration(
                              color: const Color(0xFF808080),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(3.r),
                              ),
                            ),
                          ),
                    // Container(
                    //   width: 115.w,
                    //   height: 10.h,
                    //   decoration: ShapeDecoration(
                    //     color: const Color(0xFF808080),
                    //     shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(3.r),
                    //     ),
                    //   ),
                    // ),
                    SizedBox(
                      height: 40.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        sheetSize == 1.0
                            ? GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                    left: 40.w,
                                  ),
                                  padding: EdgeInsets.all(2.sp),
                                  child: Icon(
                                    Icons.keyboard_arrow_down,
                                    size: 45.sp,
                                  ),
                                ),
                              )
                            : SizedBox(
                                width: 5.w,
                              ),
                        Text(
                          'Select Style',
                          style: TextStyle(
                            fontSize: 23.sp,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1.61,
                          ),
                        ),
                        sheetSize == 1.0
                            ? Container(
                                width: 5.w,
                                margin: EdgeInsets.only(
                                  right: 50.w,
                                ),
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),
                    // Text(
                    //   'Select Style',
                    //   style: TextStyle(
                    //     fontSize: 23.sp,
                    //     fontFamily: 'Poppins',
                    //     fontWeight: FontWeight.w500,
                    //     letterSpacing: 1.61,
                    //   ),
                    // ),
                    SizedBox(
                      height: 25.h,
                    ),
                    Divider(
                      thickness: 1.w,
                    ),
                    Expanded(
                      child: DefaultTabController(
                        length: 2,
                        initialIndex: _selectedIndex,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                TabBar(
                                  controller: _controller,
                                  dividerColor: transparentColor,
                                  indicatorSize: TabBarIndicatorSize.label,
                                  indicator: BoxDecoration(
                                    borderRadius: BorderRadius.circular(33.r),
                                  ),
                                  isScrollable: true,
                                  splashFactory: NoSplash.splashFactory,
                                  padding: EdgeInsets.only(
                                    left: 22.w,
                                    right: 22.w,
                                  ),
                                  unselectedLabelColor: const Color(0xFFF5F5F5),
                                  // automaticIndicatorColorAdjustment: true,
                                  labelColor: Colors.white,
                                  indicatorPadding: EdgeInsets.zero,
                                  labelPadding: EdgeInsets.only(
                                    left: 15.w,
                                    right: 15.w,
                                  ),
                                  splashBorderRadius:
                                      BorderRadius.circular(33.r),
                                  tabs: [
                                    Tab(
                                      height: 55.h,
                                      child: Container(
                                        width: 167.w,
                                        height: 55.h,
                                        decoration: _controller.index == 1
                                            ? ShapeDecoration(
                                                color: iconColor,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          33.r),
                                                ),
                                              )
                                            : ShapeDecoration(
                                                gradient: gradientColorT,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          33.r),
                                                ),
                                              ),
                                        child: Center(
                                          child: Text(
                                            'Popular',
                                            style: TextStyle(
                                              fontSize: 18.sp,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w400,
                                              letterSpacing: 0.54,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Tab(
                                      height: 55.h,
                                      child: Container(
                                        width: 167.w,
                                        height: 55.h,
                                        decoration: _controller.index == 0
                                            ? ShapeDecoration(
                                                color: iconColor,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          33.r),
                                                ),
                                              )
                                            : ShapeDecoration(
                                                gradient: gradientColorT,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          33.r),
                                                ),
                                              ),
                                        child: Center(
                                          child: Text(
                                            'Favorites',
                                            style: TextStyle(
                                              fontSize: 18.sp,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w400,
                                              letterSpacing: 0.54,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Expanded(
                              child: TabBarView(
                                controller: _controller,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(
                                      left: 25.w,
                                      right: 25.w,
                                      top: 30.h,
                                    ),
                                    height:
                                        MediaQuery.sizeOf(context).height * .75,
                                    child: GridView.builder(
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 4,
                                        mainAxisExtent: 230.h,
                                        mainAxisSpacing: 10.h,
                                        crossAxisSpacing: 10.w,
                                      ),
                                      itemCount: value.stylesImages.length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            // value.changeSelected(index);
                                            value.changeSelectedStyle(
                                                value.stylesImages[index].name);
                                            setState(() {});
                                          },
                                          child: SizedBox(
                                            child: Stack(
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.only(
                                                    right: 10.w,
                                                    top: 10.h,
                                                  ),
                                                  padding: EdgeInsets.only(
                                                    top: 6.h,
                                                    bottom: 6.h,
                                                    left: 6.w,
                                                    right: 6.w,
                                                  ),
                                                  decoration: ShapeDecoration(
                                                    // color: iconColor,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15.r),
                                                    ),
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      SizedBox(
                                                        child: Stack(
                                                          children: [
                                                            Container(
                                                              decoration:
                                                                  ShapeDecoration(
                                                                      shape:
                                                                          RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15.r),
                                                                side:
                                                                    BorderSide(
                                                                  width: 2.w,
                                                                  color: value.selectedStyle ==
                                                                          value
                                                                              .stylesImages[index]
                                                                              .name
                                                                      ? mainColor
                                                                      : transparentColor,
                                                                ),
                                                              )),
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15.r),
                                                                child:
                                                                    CachedNetworkImage(
                                                                  width: 160.w,
                                                                  height: 155.h,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  imageUrl: value
                                                                      .stylesImages[
                                                                          index]
                                                                      .thumb
                                                                      .toString(),
                                                                  placeholder:
                                                                      (context,
                                                                              url) =>
                                                                          SizedBox(
                                                                    width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width,
                                                                    height: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height,
                                                                    child:
                                                                        Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color:
                                                                            iconColor,
                                                                        borderRadius:
                                                                            BorderRadius.circular(20.r),
                                                                      ),
                                                                      padding:
                                                                          EdgeInsets
                                                                              .only(
                                                                        top: 10
                                                                            .h,
                                                                        right:
                                                                            10.w,
                                                                        left: 10
                                                                            .w,
                                                                        bottom:
                                                                            10.h,
                                                                      ),
                                                                      child:
                                                                          Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          LottieBuilder
                                                                              .asset(
                                                                            "assets/icons/Processing_Image.json",
                                                                            width:
                                                                                85.w,
                                                                            height:
                                                                                85.h,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    // Shimmer
                                                                    //     .fromColors(
                                                                    //   baseColor: Colors
                                                                    //       .grey
                                                                    //       .shade300,
                                                                    //   highlightColor:
                                                                    //       Colors.grey
                                                                    //           .shade100,
                                                                    //   child: Container(
                                                                    //     color: gray,
                                                                    //   ),
                                                                    // ),
                                                                  ),
                                                                  errorWidget: (context,
                                                                          url,
                                                                          error) =>
                                                                      const Icon(
                                                                          Icons
                                                                              .error),
                                                                ),
                                                              ),
                                                            ),
                                                            Positioned(
                                                              right: 8.w,
                                                              bottom: 8.h,
                                                              child:
                                                                  GestureDetector(
                                                                onTap: () {
                                                                  if (value
                                                                      .stylesImages[
                                                                          index]
                                                                      .isFavorite!) {
                                                                    value.removeStyle(value
                                                                        .stylesImages[
                                                                            index]
                                                                        .name);
                                                                    print(
                                                                        "before delete");
                                                                    db?.deleteFavorite(value
                                                                        .stylesImages[
                                                                            index]
                                                                        .name!
                                                                        .toString());
                                                                    print(
                                                                        "after delete");
                                                                  } else {
                                                                    value.addStyle(
                                                                        index);
                                                                    FavoriteCompanion
                                                                        model =
                                                                        FavoriteCompanion(
                                                                      id: d.Value(
                                                                          index),
                                                                      imagePath: d.Value(value
                                                                          .stylesImages[
                                                                              index]
                                                                          .thumb
                                                                          .toString()),
                                                                      description: d.Value(value
                                                                          .stylesImages[
                                                                              index]
                                                                          .name
                                                                          .toString()),
                                                                      type: const d
                                                                          .Value(
                                                                          "Style"),
                                                                      isFavorite: const d
                                                                          .Value(
                                                                          true),
                                                                    );
                                                                    db?.saveFavorite(
                                                                        model);
                                                                  }
                                                                  setState(
                                                                      () {});
                                                                },
                                                                child: Icon(
                                                                  value
                                                                          .stylesImages[
                                                                              index]
                                                                          .isFavorite!
                                                                      ? Icons
                                                                          .favorite
                                                                      : Icons
                                                                          .favorite_border,
                                                                  color: value
                                                                          .stylesImages[
                                                                              index]
                                                                          .isFavorite!
                                                                      ? favorite
                                                                      : null,
                                                                  size: 35.sp,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 5.h,
                                                      ),
                                                      Text(
                                                        value
                                                            .stylesImages[index]
                                                            .name!,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          fontSize: 18.sp,
                                                          fontFamily: 'Poppins',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                value.stylesImages[index]
                                                            .isPro ==
                                                        "true"
                                                    ? Positioned(
                                                        right: 0.w,
                                                        child: Image.asset(
                                                          "assets/styles/pro.png",
                                                          width: 35.w,
                                                          height: 35.h,
                                                        ),
                                                      )
                                                    : const SizedBox.shrink(),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  FutureBuilder(
                                      future: db?.getAllFavorite(),
                                      builder: (context, snapshot) {
                                        return Container(
                                          padding: EdgeInsets.only(
                                            left: 25.w,
                                            right: 25.w,
                                            top: 30.h,
                                          ),
                                          height: MediaQuery.sizeOf(context)
                                                  .height *
                                              .75,
                                          child:
                                              snapshot.data?.isNotEmpty == true
                                                  ? GridView.builder(
                                                      physics:
                                                          const NeverScrollableScrollPhysics(),
                                                      gridDelegate:
                                                          SliverGridDelegateWithFixedCrossAxisCount(
                                                        crossAxisCount: 4,
                                                        mainAxisExtent: 230.h,
                                                        mainAxisSpacing: 10.h,
                                                        crossAxisSpacing: 10.w,
                                                      ),
                                                      itemCount:
                                                          snapshot.data?.length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return GestureDetector(
                                                          onTap: () {
                                                            // value
                                                            //     .changeSelected(
                                                            //         index);

                                                            var selected = value
                                                                .stylesImages
                                                                .where((element) =>
                                                                    element
                                                                        .name ==
                                                                    snapshot
                                                                        .data?[
                                                                            index]
                                                                        .description)
                                                                .toList();
                                                            print(selected[0]
                                                                .name);
                                                            value
                                                                .changeSelectedStyle(
                                                                    selected[0]
                                                                        .name);
                                                            print(value
                                                                .selectedStyle);
                                                            setState(() {});
                                                          },
                                                          child: SizedBox(
                                                            child: Stack(
                                                              children: [
                                                                Container(
                                                                  margin:
                                                                      EdgeInsets
                                                                          .only(
                                                                    right: 10.w,
                                                                    top: 10.h,
                                                                  ),
                                                                  padding:
                                                                      EdgeInsets
                                                                          .only(
                                                                    top: 6.h,
                                                                    bottom:
                                                                        11.h,
                                                                    left: 6.w,
                                                                    right: 6.w,
                                                                  ),
                                                                  decoration:
                                                                      ShapeDecoration(
                                                                    // color: iconColor,
                                                                    shape:
                                                                        RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15.r),
                                                                    ),
                                                                  ),
                                                                  child: Column(
                                                                    children: [
                                                                      SizedBox(
                                                                        child:
                                                                            Stack(
                                                                          children: [
                                                                            Container(
                                                                              decoration: ShapeDecoration(
                                                                                  shape: RoundedRectangleBorder(
                                                                                borderRadius: BorderRadius.circular(15.r),
                                                                                side: BorderSide(
                                                                                  width: 2.w,
                                                                                  color: value.selectedStyle == snapshot.data![index].description ? mainColor : transparentColor,
                                                                                ),
                                                                              )),
                                                                              child: ClipRRect(
                                                                                borderRadius: BorderRadius.circular(15.r),
                                                                                child: CachedNetworkImage(
                                                                                  width: 160.w,
                                                                                  height: 155.h,
                                                                                  fit: BoxFit.cover,
                                                                                  imageUrl: snapshot.data![index].imagePath,
                                                                                  // value.favStyle[index].thumb.toString(),
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
                                                                                  errorWidget: (context, url, error) => const Icon(Icons.error),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Positioned(
                                                                              right: 8.w,
                                                                              bottom: 8.h,
                                                                              child: GestureDetector(
                                                                                onTap: () {
                                                                                  // value.removeStyle(value.favStyle[index]);
                                                                                  value.removeStyle(snapshot.data![index].description);
                                                                                  db!.deleteFavorite(snapshot.data![index].description);

                                                                                  setState(() {});
                                                                                },
                                                                                child: Icon(
                                                                                  snapshot.data![index].isFavorite ? Icons.favorite : Icons.favorite_border,
                                                                                  color: snapshot.data![index].isFavorite ? favorite : null,
                                                                                  size: 35.sp,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            5.h,
                                                                      ),
                                                                      Text(
                                                                        snapshot
                                                                            .data![index]
                                                                            .description,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              18.sp,
                                                                          fontFamily:
                                                                              'Poppins',
                                                                          fontWeight:
                                                                              FontWeight.w400,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                value.stylesImages
                                                                        .any(
                                                                            (element) {
                                                                  if (element
                                                                          .name ==
                                                                      snapshot
                                                                          .data![
                                                                              index]
                                                                          .description) {
                                                                    var pro = element.isPro ==
                                                                            "true"
                                                                        ? true
                                                                        : false;
                                                                    return pro;
                                                                  }
                                                                  return false;
                                                                })
                                                                    ? Positioned(
                                                                        right:
                                                                            0.w,
                                                                        child: Image
                                                                            .asset(
                                                                          "assets/styles/pro.png",
                                                                          width:
                                                                              35.w,
                                                                          height:
                                                                              35.h,
                                                                        ),
                                                                      )
                                                                    : const SizedBox
                                                                        .shrink(),
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    )
                                                  : Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Opacity(
                                                          opacity: 0.60,
                                                          child: Text(
                                                            'Not favorite is added yet!',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                              fontSize: 25.sp,
                                                              fontFamily:
                                                                  'Poppins',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              letterSpacing:
                                                                  0.75,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                        );
                                      }),
                                ],
                              ),
                            ),
                            sheetSize == 1.0
                                ? Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      width: 115.w,
                                      height: 10.h,
                                      decoration: ShapeDecoration(
                                        color: const Color(0xFF808080),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(3.r),
                                        ),
                                      ),
                                    ),
                                  )
                                : const SizedBox.shrink(),
                            SizedBox(
                              height: 20.h,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
