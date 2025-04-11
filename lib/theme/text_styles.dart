import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';

class AppTextStyles {
  static final TextStyle title = GoogleFonts.roboto(
    fontSize: 32,
    fontWeight: FontWeight.w500, // Medium
    color: AppColors.primaryText,
  );

  static final TextStyle subtitle = GoogleFonts.roboto(
    fontSize: 28,
    fontWeight: FontWeight.w500,
    color: AppColors.primaryText,
  );

  static final TextStyle body = GoogleFonts.roboto(
    fontSize: 18,
    fontWeight: FontWeight.w400, // Regular
    color: AppColors.primaryText,
  );

  static final TextStyle small = GoogleFonts.roboto(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.primaryText,
  );
}
