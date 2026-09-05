import 'package:flutter/material.dart';
import 'package:tasky/core/constants/app_sizes.dart';

ThemeData lightTheme(BuildContext context) {
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      primaryContainer: Color(0xFFFFFFFF),
      onSecondary: Color(0xFF161F1B),
      surfaceContainerHigh: Color(0xFF6A6A6A),
      // ? selected
      surfaceContainerLow: Color(0xFF3A4640),
      // ? unselected
      onSecondaryFixed: Color(0xFF14A662),
      //? selected SvgPicture in bottom Navigation
      onSecondaryFixedVariant: Color(
        0xFF3A4640,
      ), //? unselected SvgPicture in bottom Navigation
    ),
    scaffoldBackgroundColor: Color(0xFFF6F7F9),
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFFF6F7F9),
      centerTitle: true,
      foregroundColor: Color(0xFF161F1B),
      titleTextStyle: TextStyle(
        fontSize: AppSizes.sp20,
        color: Color(0xFF161F1B),
        fontWeight: FontWeight.w400,
      ),
    ),
    switchTheme: SwitchThemeData(
      trackColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.selected)) {
          return Color(0xFF15B86C);
        }
        return Colors.white;
      }),
      thumbColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.selected)) {
          return Colors.white;
        }
        return Color(0xFF9E9E9E);
      }),
      trackOutlineColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.selected)) {
          return Colors.transparent;
        }
        return Color(0xFF9E9E9E);
      }),
      trackOutlineWidth: WidgetStateProperty.resolveWith<double>((states) {
        if (states.contains(WidgetState.selected)) {
          return 0;
        }
        return 2;
      }),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: Color(0xFF14A662),
        foregroundColor: Color(0xFFFFFFFF),
        fixedSize: Size(MediaQuery.of(context).size.width, AppSizes.h40),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.r100),
        ),
        textStyle: TextStyle(
          color: Color(0xFFFFFFFF),
          fontSize: AppSizes.sp14,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: Color(0xFF161F1B),
      ),
    ),
    textTheme: TextTheme(
      displayLarge: TextStyle(
        fontSize: AppSizes.sp32,
        fontWeight: FontWeight.w400,
        color: Color(0xFF161F1B),
      ),
      displayMedium: TextStyle(
        fontSize: AppSizes.sp28,
        fontWeight: FontWeight.w400,
        color: Color(0xFF161F1B),
      ),
      displaySmall: TextStyle(
        fontSize: AppSizes.sp24,
        fontWeight: FontWeight.w400,
        color: Color(0xFF161F1B),
      ),
      bodyLarge: TextStyle(
        fontSize: AppSizes.sp20,
        fontWeight: FontWeight.w400,
        color: Color(0xFF161F1B),
      ),
      labelLarge: TextStyle(
        color: Color(0xFF161F1B),
        fontSize: AppSizes.sp16,
        fontWeight: FontWeight.w400,
      ),
      labelMedium: TextStyle(
        fontSize: AppSizes.sp14,
        fontWeight: FontWeight.w400,
        color: Color(0xFF161F1B),
      ),
      labelSmall: TextStyle(
        fontSize: AppSizes.sp14,
        fontWeight: FontWeight.w400,
        color: Color(0xFF3A4640),
      ),
      //? selected text font
      headlineMedium: TextStyle(
        fontSize: AppSizes.sp16,
        decoration: TextDecoration.lineThrough,
        decorationColor: const Color(0xFF6A6A6A),
        fontWeight: FontWeight.w400,
        color: Color(0xFF6A6A6A),
      ),
      //? green text font
      headlineSmall: TextStyle(
        color: Color(0xFF15B86C),
        fontWeight: FontWeight.w400,
        fontSize: AppSizes.sp14,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Color(0xFFFFFFFF),
      hintStyle: TextStyle(
        fontSize: AppSizes.sp14,
        fontWeight: FontWeight.w400,
        color: Color(0xFF9E9E9E),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.r16),
        borderSide: BorderSide(color: Color(0xFFD1DAD6)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.r16),
        borderSide: BorderSide(color: Color(0xFFD1DAD6)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.r16),
        borderSide: BorderSide(color: Color(0xFFD1DAD6)),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.r16),
        borderSide: BorderSide(color: Colors.redAccent, width: 0.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.r16),
        borderSide: BorderSide(color: Colors.redAccent, width: 0.5),
      ),
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: Color(0xFF15B86C),
      circularTrackColor: Color(0xFF9E9E9E),
      strokeWidth: 4,
    ),
    checkboxTheme: CheckboxThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.r4)),
      side: BorderSide(color: Color(0xFFD1DAD6), width: 2),
      checkColor: WidgetStatePropertyAll(Color(0xFFFFFFFF)),
      fillColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.selected)) {
          return Color(0xFF15B86C);
        }
        return Color(0xFFFFFFFF);
      }),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Color(0xFF15B86C),
      foregroundColor: Color(0xFFFFFCFC),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.r30)),
      extendedTextStyle: TextStyle(
        fontSize: AppSizes.sp14,
        fontWeight: FontWeight.w500,
      ),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: Color(0xFF15B86C),
      selectionColor: Color(0xFF15B86C).withValues(alpha: 0.5),
      selectionHandleColor: Color(0xFF15B86C),
    ),
    listTileTheme: ListTileThemeData(
      contentPadding: EdgeInsets.zero,
      titleTextStyle: TextStyle(
        color: Color(0xFF161F1B),
        fontWeight: FontWeight.w400,
        fontSize: AppSizes.sp16,
      ),
      iconColor: Color(0xFF3A4640),
    ),
    dividerTheme: DividerThemeData(color: Color(0xFFD1DAD6), thickness: 1),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Color(0xFFF6F7F9),
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Color(0xFF14A662),
      unselectedItemColor: Color(0xFF3A4640),
    ),
    splashFactory: NoSplash.splashFactory,
    popupMenuTheme: PopupMenuThemeData(
      color: Color(0xFFFFFFFF),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Color(0xFFD1DAD6), width: 0.7),
        borderRadius: BorderRadius.circular(AppSizes.r20),
      ),
      elevation: 3,
      shadowColor: Color(0xFFD1DAD6),
      textStyle: TextStyle(
        fontSize: AppSizes.sp20,
        fontWeight: FontWeight.w400,
        color: Color(0xFF161F1B),
      ),
    ),
  );
}
