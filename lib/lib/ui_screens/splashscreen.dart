import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nb_utils/nb_utils.dart';

import 'home/home_screen.dart';
import 'language/language_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    init();
  }

  void init() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    bool isFirstTime = preferences.getBool('isFirstTime') ?? false;
    Timer(const Duration(seconds: 3), () {
      isFirstTime
          ? const HomeScreen().launch(context, isNewTask: true)
          :
          // const NoInternetScreen().launch(context,isNewTask: true);
          LanguageScreen(
              isSetting: false,
            ).launch(context, isNewTask: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          left: 185.w,
          right: 185.w,
        ),
        child: Center(
          child: Image.asset(
            "assets/splash.png",
          ),
        ),
      ),
    );
  }
}
