import 'package:ai_art_gen/database/database.dart';
import 'package:ai_art_gen/provider/selection_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:drift/drift.dart' as d;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../constants/color_constants.dart';
import '../main.dart';

class ModelSheet extends StatefulWidget {
  const ModelSheet({super.key});

  @override
  State<ModelSheet> createState() => _ModelSheetState();
}

class _ModelSheetState extends State<ModelSheet>
    with SingleTickerProviderStateMixin {
  bool isLoaded = true;
  bool newTab = false;
  late TabController _controller;
  int _selectedIndex = 0;
  double sheetSize = 0.0;

  final modelController = DraggableScrollableController();

  @override
  void dispose() {
    _controller.dispose();
    modelController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    modelController.addListener(() {
      if (modelController.isAttached) {
        sheetSize = modelController.size;
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
      controller: modelController,
      builder: (context, scrollController) {
        return Consumer<SelectionProvider>(
          builder: (context, value, child) {
            return SingleChildScrollView(
              controller: scrollController,
              child: Container(
                padding: EdgeInsets.only(
                  top: 30.h,
                  bottom: 10.h,
                  left: 40.w,
                  right: 40.w,
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
                          'Select Model',
                          style: TextStyle(
                            fontSize: 23.sp,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1.61,
                          ),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                      ],
                    ),

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
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 4,
                                        mainAxisExtent: 230.h,
                                        mainAxisSpacing: 10.h,
                                        crossAxisSpacing: 10.w,
                                      ),
                                      itemCount: value.modelsImages.length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            value.changeSelectedM(value
                                                .modelsImages[index].modelName);
                                            //  setState(() {});
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
                                                    bottom: 11.h,
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
                                                      !isLoaded
                                                          ? Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                color:
                                                                    iconColor,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20.r),
                                                              ),
                                                              padding:
                                                                  EdgeInsets
                                                                      .only(
                                                                top: 10.h,
                                                                right: 10.w,
                                                                left: 10.w,
                                                                bottom: 10.h,
                                                              ),
                                                              width: 152.w,
                                                              height: 152.h,
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  LottieBuilder
                                                                      .asset(
                                                                    "assets/icons/Processing_Image.json",
                                                                    width: 90.w,
                                                                    height:
                                                                        90.h,
                                                                  ),
                                                                ],
                                                              ),
                                                            )
                                                          : SizedBox(
                                                              child: Stack(
                                                                children: [
                                                                  Container(
                                                                    decoration:
                                                                        ShapeDecoration(
                                                                            shape:
                                                                                RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15.r),
                                                                      side:
                                                                          BorderSide(
                                                                        width:
                                                                            2.w,
                                                                        color: value.selectedM ==
                                                                                value.modelsImages[index].modelName
                                                                            ? mainColor
                                                                            : transparentColor,
                                                                      ),
                                                                    )),
                                                                    child:
                                                                        ClipRRect(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15.r),
                                                                      child:
                                                                          CachedNetworkImage(
                                                                        width:
                                                                            110.w,
                                                                        height:
                                                                            130.h,
                                                                        fit: BoxFit
                                                                            .cover,
                                                                        imageUrl: value
                                                                            .modelsImages[index]
                                                                            .filename
                                                                            .toString(),
                                                                        placeholder:
                                                                            (context, url) =>
                                                                                SizedBox(
                                                                          width: MediaQuery.of(context)
                                                                              .size
                                                                              .width,
                                                                          height: MediaQuery.of(context)
                                                                              .size
                                                                              .height,
                                                                          child:
                                                                              Container(
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: iconColor,
                                                                              borderRadius: BorderRadius.circular(20.r),
                                                                            ),
                                                                            padding:
                                                                                EdgeInsets.only(
                                                                              top: 10.h,
                                                                              right: 10.w,
                                                                              left: 10.w,
                                                                              bottom: 10.h,
                                                                            ),
                                                                            child:
                                                                                Column(
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
                                                                        errorWidget: (context,
                                                                                url,
                                                                                error) =>
                                                                            const Icon(Icons.error),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Positioned(
                                                                    right: 8.w,
                                                                    bottom: 8.h,
                                                                    child:
                                                                        GestureDetector(
                                                                      onTap:
                                                                          () async {
                                                                        if (value
                                                                            .modelsImages[index]
                                                                            .isFavorite!) {
                                                                          value.removeModel(value
                                                                              .modelsImages[index]
                                                                              .modelName);
                                                                          print(
                                                                              "before delete");
                                                                          await db?.deleteModelFavorite(value
                                                                              .modelsImages[index]
                                                                              .modelName!
                                                                              .toString());
                                                                          print(
                                                                              "after delete");
                                                                        } else {
                                                                          value.addModel(
                                                                              index);
                                                                          ModelFavoriteCompanion
                                                                              model =
                                                                              ModelFavoriteCompanion(
                                                                            id: d.Value(index),
                                                                            path:
                                                                                d.Value(value.modelsImages[index].filename.toString()),
                                                                            modelName:
                                                                                d.Value(value.modelsImages[index].modelName.toString()),
                                                                            proUserAccess:
                                                                                const d.Value(false),
                                                                            isFavorite:
                                                                                const d.Value(true),
                                                                          );
                                                                          await db
                                                                              ?.saveModelFavorite(model);
                                                                        }
                                                                        setState(
                                                                            () {});
                                                                      },
                                                                      child:
                                                                          Icon(
                                                                        value.modelsImages[index].isFavorite
                                                                            ? Icons.favorite
                                                                            : Icons.favorite_border,
                                                                        color: value.modelsImages[index].isFavorite
                                                                            ? favorite
                                                                            : null,
                                                                        size: 35
                                                                            .sp,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                      SizedBox(
                                                        height: 5.h,
                                                      ),
                                                      SizedBox(
                                                        width: 105.w,
                                                        child: Text(
                                                            value
                                                                .modelsImages[
                                                                    index]
                                                                .modelName,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            textAlign: TextAlign
                                                                .center,
                                                            maxLines: 2,
                                                            style: TextStyle(
                                                              fontSize: 14.sp,
                                                              fontFamily:
                                                                  'Poppins',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            )),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  FutureBuilder(
                                      future: db?.getAllModelFavorite(),
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
                                                            var selected = value
                                                                .modelsImages
                                                                .where((element) =>
                                                                    element
                                                                        .modelName ==
                                                                    snapshot
                                                                        .data?[
                                                                            index]
                                                                        .modelName)
                                                                .toList();
                                                            value.changeSelectedM(
                                                                selected[0]
                                                                    .modelName);
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
                                                                      !isLoaded
                                                                          ? Container(
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
                                                                              width: 152.w,
                                                                              height: 152.h,
                                                                              child: Column(
                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                children: [
                                                                                  LottieBuilder.asset(
                                                                                    "assets/icons/Processing_Image.json",
                                                                                    width: 90.w,
                                                                                    height: 90.h,
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            )
                                                                          : SizedBox(
                                                                              child: Stack(
                                                                                children: [
                                                                                  Container(
                                                                                    decoration: ShapeDecoration(
                                                                                        shape: RoundedRectangleBorder(
                                                                                      borderRadius: BorderRadius.circular(15.r),
                                                                                      side: BorderSide(
                                                                                        width: 2.w,
                                                                                        color: value.selectedM == snapshot.data![index].modelName ? mainColor : transparentColor,
                                                                                      ),
                                                                                    )),
                                                                                    child: ClipRRect(
                                                                                      borderRadius: BorderRadius.circular(15.r),
                                                                                      child: CachedNetworkImage(
                                                                                        width: 110.w,
                                                                                        height: 135.h,
                                                                                        fit: BoxFit.cover,
                                                                                        imageUrl: snapshot.data![index].path,
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
                                                                                    right: 6.w,
                                                                                    bottom: 6.h,
                                                                                    child: GestureDetector(
                                                                                      onTap: () {
                                                                                        value.removeModel(snapshot.data![index].modelName);
                                                                                        db!.deleteModelFavorite(snapshot.data![index].modelName);

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
                                                                            .modelName!,
                                                                        maxLines:
                                                                            2,
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              14.sp,
                                                                          fontFamily:
                                                                              'Poppins',
                                                                          fontWeight:
                                                                              FontWeight.w400,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                // value
                                                                //             .favModel[
                                                                //                 index]
                                                                //             .data!
                                                                //             .description! ==
                                                                //         "None"
                                                                //     ? const SizedBox
                                                                //         .shrink()
                                                                //     : value
                                                                //             .favModel[
                                                                //                 index]
                                                                //             .isPro!
                                                                //         ? Positioned(
                                                                //             right: 0.w,
                                                                //             child: Image
                                                                //                 .asset(
                                                                //               "assets/styles/pro.png",
                                                                //               width: 35.w,
                                                                //               height:
                                                                //                   35.h,
                                                                //             ),
                                                                //           )
                                                                //         : const SizedBox
                                                                //             .shrink(),
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    )
                                                  : Column(
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
                                                        SizedBox(
                                                          height: 20.h,
                                                        ),
                                                      ],
                                                    ),
                                        );
                                      }),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Spacer(),
                    sheetSize == 1.0
                        ? Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              width: 115.w,
                              height: 10.h,
                              decoration: ShapeDecoration(
                                color: const Color(0xFF808080),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(3.r),
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
            );
          },
        );
      },
    );
  }
}
