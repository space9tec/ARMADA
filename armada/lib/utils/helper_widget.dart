import 'package:flutter/material.dart';

Widget addVerticalSpace(double height) {
  return SizedBox(
    height: height,
  );
}

Widget addHorizontalSpace(double width) {
  return SizedBox(
    width: width,
  );
}

Widget listTileUpperLine(double leftPadding) {
  return Padding(
    padding: EdgeInsets.only(left: leftPadding),
    child: const SizedBox(
      height: 1,
      child: ColoredBox(color: Colors.black),
    ),
  );
}
