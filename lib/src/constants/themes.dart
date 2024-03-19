import 'package:dicoding_food_deli/src/constants/colors.dart';
import 'package:dicoding_food_deli/src/constants/fonts.dart';

import 'package:flutter/material.dart';

final ThemeData myTheme = ThemeData(
  fontFamily: AppFonts.primaryFont,
  brightness: Brightness.light,
  useMaterial3: true,
  colorScheme: const ColorScheme(
    background: kWhiteColor,
    brightness: Brightness.light,
    primary: kPrimaryColor,
    onPrimary: kWhiteColor,
    secondary: kSecondaryColor,
    onSecondary: kSecondaryColor,
    onBackground: Colors.black,
    error: Colors.red,
    onError: Colors.white,
    surface: kWhiteColor,
    onSurface: Colors.black,
  ),
);
