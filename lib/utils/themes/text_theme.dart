import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pharmacy_store/utils/constants/colors.dart';

TextTheme textTheme = TextTheme(
  titleLarge: GoogleFonts.robotoSlab(
    fontSize:18,
    color:kTitleColor,
    fontWeight:FontWeight.bold,
  ),
  titleMedium: GoogleFonts.robotoSlab(
    fontSize:16,
    color:kPrimaryColor,
    fontWeight:FontWeight.bold,
  ),
  titleSmall: GoogleFonts.robotoSlab(
    fontSize:15,
    color:kTitleColor,
    fontWeight:FontWeight.bold,
  ),
);