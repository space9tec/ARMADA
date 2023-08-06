import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTheme {
  ThemeData getTheme(bool isDarkMode) {
    final Color primaryColor = isDarkMode
        ? Color.fromARGB(255, 1, 65, 35)
        : Color(0xFF006837); // half done
    final Color accentColor = isDarkMode
        ? const Color.fromARGB(255, 94, 93, 93)
        : Colors.grey; // half done

    final TextTheme baseTextTheme = _buildBaseTextTheme(isDarkMode); // done

    return ThemeData(
      brightness: isDarkMode ? Brightness.dark : Brightness.light,
      primaryColor: primaryColor,
      hintColor: accentColor,
      textTheme: _buildBaseTextTheme(isDarkMode),
      appBarTheme: _buildAppBarTheme(baseTextTheme, isDarkMode),
      buttonTheme: _buildButtonTheme(primaryColor),
      cardTheme: _buildCardTheme(),
      dialogTheme: _buildDialogTheme(),
      // datePickerTheme: _buildDatepickerTheme(),
      floatingActionButtonTheme: _buildFabTheme(isDarkMode),
      iconTheme: _buildIconTheme(isDarkMode),
      popupMenuTheme: _buildPopupMenuTheme(),
      progressIndicatorTheme: _buildProgressIndicatorTheme(isDarkMode),
      bottomAppBarTheme: bottomAppBarTheme(isDarkMode),
    );
  }

  TextTheme _buildBaseTextTheme(bool isDarkMode) {
    final Color textColor = isDarkMode ? Colors.white : Colors.black;

    return Typography.material2018().black.merge(TextTheme(
          displayLarge: GoogleFonts.inter(
            color: textColor,
            fontSize: 32,
            fontWeight: FontWeight.w900,
          ),
          displayMedium: GoogleFonts.inter(
            color: textColor,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
          displaySmall: GoogleFonts.poppins(
            color: textColor,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          bodyLarge: GoogleFonts.poppins(
            color: textColor,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
          bodyMedium: GoogleFonts.poppins(
            color: textColor,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          bodySmall: GoogleFonts.poppins(
            color: textColor,
            fontSize: 12,
            fontWeight: FontWeight.normal,
          ),
          titleLarge: GoogleFonts.poppins(
            color: textColor,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
          titleMedium: GoogleFonts.poppins(
            color: textColor,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          titleSmall: GoogleFonts.poppins(
            color: textColor,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ));
  }

  AppBarTheme _buildAppBarTheme(TextTheme baseTextTheme, bool isDarkMode) {
    final Color? appBarColor =
        isDarkMode ? Colors.grey[900] : Color(0xFF006837);

    return AppBarTheme(
      color: appBarColor,
    );
  }

  // DatePickerTheme _buildDatepickerTheme(bool isDarkMode) {
  //   final Color? textcolor =
  //       isDarkMode ? const Color.fromARGB(255, 248, 248, 248) : Colors.black;
  //   return DatePickerTheme(
  //     data: DatePickerThemeData(
  //       backgroundColor: isDarkMode ? Colors.black : Colors.white,
  //       shadowColor: isDarkMode ? Colors.grey[800] : Colors.blue,
  //       headerHelpStyle: TextStyle(color: Colors.white),
  //       dayStyle: TextStyle(color: Colors.black),
  //     ),
  //   );
  // }

  ButtonThemeData _buildButtonTheme(Color primaryColor) {
    return ButtonThemeData(
      buttonColor: primaryColor,
      textTheme: ButtonTextTheme.primary,
    );
  }

  CardTheme _buildCardTheme() {
    return CardTheme(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  DialogTheme _buildDialogTheme() {
    return DialogTheme(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }

  FloatingActionButtonThemeData _buildFabTheme(bool isDarkMode) {
    final Color? floatactionbuttoncolor = isDarkMode
        ? const Color.fromARGB(255, 248, 248, 248)
        : Color(0xFF006837);
    return FloatingActionButtonThemeData(
      backgroundColor: floatactionbuttoncolor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
    );
  }

  IconThemeData _buildIconTheme(bool isDarkMode) {
    final Color iconColor = isDarkMode ? Colors.white : Colors.black;

    return IconThemeData(
      color: iconColor,
      size: 24,
    );
  }

  PopupMenuThemeData _buildPopupMenuTheme() {
    return PopupMenuThemeData(
      color: Colors.grey[200],
    );
  }

  ProgressIndicatorThemeData _buildProgressIndicatorTheme(bool isDarkMode) {
    final Color? progressbarcolor = isDarkMode
        ? const Color.fromARGB(255, 248, 248, 248)
        : Color(0xFF006837);
    return ProgressIndicatorThemeData(
      color: progressbarcolor,
      linearMinHeight: 48,
    );
  }

  // TextTheme textTheme() {
  //   return TextTheme(
  // displayLarge: GoogleFonts.inter(
  //   color: Colors.black,
  //   fontSize: 32,
  //   fontWeight: FontWeight.w900,
  // ),
  // displayMedium: GoogleFonts.inter(
  //   color: Colors.black,
  //   fontSize: 24,
  //   fontWeight: FontWeight.w600,
  // ),
  // displaySmall: GoogleFonts.poppins(
  //   color: Colors.black,
  //   fontSize: 16,
  //   fontWeight: FontWeight.bold,
  // ),
  // bodyLarge: GoogleFonts.poppins(
  //   color: Colors.black,
  //   fontSize: 18,
  //   fontWeight: FontWeight.w600,
  // ),
  // bodyMedium: GoogleFonts.poppins(
  //   color: Colors.black,
  //   fontSize: 14,
  //   fontWeight: FontWeight.w500,
  // ),
  // bodySmall: GoogleFonts.poppins(
  //   color: Colors.black,
  //   fontSize: 12,
  //   fontWeight: FontWeight.normal,
  // ),
  // titleLarge: GoogleFonts.poppins(
  //   color: Colors.black54,
  //   fontSize: 20,
  //   fontWeight: FontWeight.w500,
  // ),
  // titleMedium: GoogleFonts.poppins(
  //   color: Colors.black,
  //   fontSize: 16,
  //   fontWeight: FontWeight.w500,
  // ),
  // titleSmall: GoogleFonts.poppins(
  //   color: Colors.black,
  //   fontSize: 14,
  //   fontWeight: FontWeight.w500,
  // ),
  //   );
  // }

  BottomAppBarTheme bottomAppBarTheme(bool isDarkMode) {
    final Color? bottomAppBar =
        isDarkMode ? Colors.grey[900] : Color(0xFF006837);
    return BottomAppBarTheme(
      color: bottomAppBar,
      elevation: 4,
    );
  }
}
