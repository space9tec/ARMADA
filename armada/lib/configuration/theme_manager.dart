import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData customtheme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    // fontFamily: 'Avenir',
    primaryColor: const Color.fromARGB(255, 10, 190, 106),

    textTheme: textTheme(),
    bottomAppBarTheme: bottomAppBarThem(),

    dialogBackgroundColor: const Color.fromARGB(255, 10, 190, 106),
  );
}

TextTheme textTheme() {
  return TextTheme(
      displayLarge: GoogleFonts.inter(
        color: Colors.black,
        fontSize: 40,
        fontWeight: FontWeight.w900,
      ),
      displayMedium: GoogleFonts.inter(
        color: Colors.black,
        fontSize: 27,
        fontWeight: FontWeight.w400,
      ),
      displaySmall: GoogleFonts.poppins(
        color: const Color.fromARGB(255, 10, 190, 106),
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: GoogleFonts.poppins(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      bodyMedium: const TextStyle(
        color: Colors.black,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
      bodySmall: GoogleFonts.poppins(
        color: const Color.fromARGB(255, 10, 190, 106),
        fontSize: 8,
        fontWeight: FontWeight.bold,
      ),
      titleLarge: GoogleFonts.poppins(
        color: Colors.black54,
        fontSize: 21,
      ),
      titleMedium: GoogleFonts.poppins(
        color: const Color.fromARGB(255, 10, 190, 106),
        fontSize: 18,
      ),
      titleSmall: GoogleFonts.poppins(
        color: Colors.grey,
        fontSize: 15,
      ));
}

BottomAppBarTheme bottomAppBarThem() {
  return const BottomAppBarTheme(
    color: Color.fromARGB(255, 8, 204, 113),
  );
}
