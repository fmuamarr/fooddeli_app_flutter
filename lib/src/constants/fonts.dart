import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppFonts {
  static const String primaryFont = 'Inter';
  static const String secondaryFont = 'Barlow';

  static final TextStyle bodyText1 = GoogleFonts.getFont(
    secondaryFont,
    fontSize: 16,
    fontWeight: FontWeight.normal,
  );

  static final TextStyle descriptionSmall = GoogleFonts.getFont(
    primaryFont,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  static final TextStyle headline1 = GoogleFonts.getFont(
    primaryFont,
    fontSize: 24,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.5,
  );

  static final TextStyle headline2 = GoogleFonts.getFont(
    primaryFont,
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  static final TextStyle cardSmall = GoogleFonts.getFont(
    secondaryFont,
    fontSize: 10,
    fontWeight: FontWeight.w600,
  );

  static final TextStyle cardSmallLight = GoogleFonts.getFont(
    secondaryFont,
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );

  static final TextStyle cardBig = GoogleFonts.getFont(
    secondaryFont,
    fontSize: 24,
    fontWeight: FontWeight.w900,
    fontStyle: FontStyle.italic,
  );
}
