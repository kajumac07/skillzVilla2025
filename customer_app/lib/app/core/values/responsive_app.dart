import 'package:flutter/material.dart';

class ResponsiveAppValue {
  late double screenWidth;
  late double screenHeight;

  ResponsiveAppValue(BuildContext context) {
    var size = MediaQuery.of(context).size;
    screenWidth = size.width;
    screenHeight = size.height;
  }
}
