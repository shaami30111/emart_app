// ignore_for_file: must_be_immutable, camel_case_types

import 'package:flutter/material.dart';

class GradientButtonCustom extends StatelessWidget {
  final onTap;
  final btnText;
  var width;
  var height;
  var decoration;

  GradientButtonCustom(
      {super.key,
      required this.onTap,
      required this.height,
      required this.decoration,
      required this.btnText,
      this.width = double.infinity});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: decoration,
        child: Center(
          child: btnText,
        ),
      ),
    );
  }
}

class smallButton extends StatelessWidget {
  Widget? icon;
  Widget? btntext;
  VoidCallback? onTap;
  BoxDecoration? decoration;
  EdgeInsets? padding;
  double? width;

  smallButton({
    super.key,
    this.icon,
    this.btntext,
    this.onTap,
    this.decoration,
    this.padding,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? null,
        padding: padding,
        alignment: Alignment.center,
        decoration: decoration,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon ?? const SizedBox.shrink(),
            const SizedBox(
              width: 10,
            ),
            btntext ?? const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
