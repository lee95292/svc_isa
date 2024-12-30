import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static Color primary = const Color(0xFF1E88E5);
  static Color secondary = const Color(0xFFFF9800);
  static Color background = const Color(0xFFF5F5F5);
  static Color cardBackground = Colors.white;
  static Color text = const Color(0xFF2D3748);
  static Color textLight = const Color(0xFF718096);
  static Color success = const Color(0xFF2E7D32);
  static Color error = const Color(0xFFD32F2F);

  static ThemeData get theme => ThemeData(
        primaryColor: primary,
        scaffoldBackgroundColor: background,
        textTheme: GoogleFonts.notoSansTextTheme(),
        appBarTheme: AppBarTheme(
          elevation: 0,
          backgroundColor: primary,
          titleTextStyle: GoogleFonts.notoSans(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        cardTheme: CardTheme(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
}
