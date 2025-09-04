import 'dart:math';

import 'package:flutter/material.dart';

import '../../resources/app_constants.dart';

mixin RandomColorMixin {
  Random random = Random();

  Color generateRandomColor() {
    int red = random.nextInt(AppConstants.rgbValue);
    int green = random.nextInt(AppConstants.rgbValue);
    int blue = random.nextInt(AppConstants.rgbValue);

    return Color.fromRGBO(red, green, blue, 0.5);
  }
}
