import 'package:flutter/material.dart';

ThemeData darkTheme(BuildContext context){
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      primaryContainer: Color(0xFF282828),
      onSecondary: Color(0xFFFFFCFC),
      surfaceContainerHigh: Color(0xFFA0A0A0), // ? selected
      surfaceContainerLow: Color(0xFFC6C6C6),  // ? unselected
      onSecondaryFixed: Color(0xFF15B86C), //? selected SvgPicture in bottom Navigation
      onSecondaryFixedVariant: Color(0xFFC6C6C6),//? unselected SvgPicture in bottom Navigation
    ),
    scaffoldBackgroundColor: Color(0xFF181818),
    appBarTheme: AppBarTheme(
      backgroundColor:  Color(0xFF181818),
      centerTitle: true,
      foregroundColor: Color(0xFFFFFCFC),
      titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
    ),
    switchTheme: SwitchThemeData(
      trackColor: WidgetStateProperty.resolveWith<Color>((states){
        if(states.contains(WidgetState.selected)){
          return Color(0xFF15B86C);
        }
        return Colors.white;
      }),
      thumbColor: WidgetStateProperty.resolveWith<Color>((states){
        if(states.contains(WidgetState.selected)){
          return Colors.white;
        }
        return Color(0xFF9E9E9E);
      }),
      trackOutlineColor: WidgetStateProperty.resolveWith<Color>((states){
        if(states.contains(WidgetState.selected)){
          return Colors.transparent;
        }
        return Color(0xFF9E9E9E);
      }),
      trackOutlineWidth: WidgetStateProperty.resolveWith<double>((states){
        if(states.contains(WidgetState.selected)){
          return 0;
        }
        return 2;
      }),
    ),
    filledButtonTheme: FilledButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all<Color>(
              Color(0xFF15B86C)
          ),
          foregroundColor: WidgetStateProperty.all<Color>(
              Color(0xFFFFFCFC)
          ),
          fixedSize: WidgetStateProperty.all<Size>(
              Size(MediaQuery.of(context).size.width, 40)
          ),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100)
              )
          ),
          textStyle: WidgetStateProperty.all<TextStyle>(
              TextStyle(
                  color: Color(0xFFFFFCFC),
                  fontSize: 14,
                  fontWeight: FontWeight.w500
              )
          ),
        )
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(
          Color(0xFFFFFCFC),
        ),
      )
    ),
    textTheme: TextTheme(
      displayLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w400,
        color: Color(0xFFFFFCFC),
      ),
      displayMedium: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w400,
        color: Color(0xFFFFFFFF),
      ),
      displaySmall: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w400,
        color: Color(0xFFFFFCFC),
      ),
      bodyLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w400,
          color: Color(0xFFFFFCFC)
      ),
      labelLarge: TextStyle(
        color: Color(0xFFFFFCFC),
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      labelMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Color(0xFFFFFFFF),
      ),
      labelSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Color(0xFFC6C6C6),
      ),
      //? selected text font
      headlineMedium: TextStyle(
        fontSize: 16,
        decoration: TextDecoration.lineThrough,
        decorationColor: const Color(0xFFC6C6C6),
        fontWeight: FontWeight.w400,
        color: Color(0xFFC6C6C6),
      ),
      //? green text font
      headlineSmall: TextStyle(
        color: Color(0xFF15B86C),
        fontWeight: FontWeight.w400,
        fontSize: 14,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Color(0xFF282828),
      hintStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Color(0xFF6D6D6D),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
          color: Colors.redAccent,
          width: 0.5
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
          color: Colors.redAccent,
          width: 0.5
        ),
      ),
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: Color(0xFF15B86C),
      circularTrackColor: Color(0xFF6D6D6D),
      strokeWidth: 4,
    ),
    checkboxTheme: CheckboxThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      side: BorderSide(
          color: Color(0xFF6E6E6E),
          width: 2
      ),
      checkColor: WidgetStatePropertyAll(
        Color(0xFFFFFFFF),
      ),
      fillColor: WidgetStateProperty.resolveWith<Color>((states){
        if(states.contains(WidgetState.selected)){
          return Color(0xFF15B86C);
        }
        return Color(0xFF282828);
      }),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Color(0xFF15B86C),
      foregroundColor: Color(0xFFFFFCFC),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      extendedTextStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: Color(0xFF15B86C),
      selectionColor: Color(0xFF15B86C).withValues(alpha: 0.5),
      selectionHandleColor: Color(0xFF15B86C),
    ),
    listTileTheme: ListTileThemeData(
      contentPadding: EdgeInsets.zero,
      titleTextStyle: TextStyle(
        color: Color(0xFFFFFCFC),
        fontWeight: FontWeight.w400,
        fontSize: 16,
      ),
      iconColor: Color(0xFFC6C6C6),
    ),
    dividerTheme: DividerThemeData(
      color: Color(0xFF6E6E6E),
      thickness: 1
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF181818),
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Color(0xFF15B86C),
      unselectedItemColor: Color(0xFFC6C6C6),
    ),
    splashFactory: NoSplash.splashFactory,
    popupMenuTheme: PopupMenuThemeData(
      color: Color(0xFF282828),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
      ),
      elevation: 3,
      textStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w400,
          color: Color(0xFFFFFCFC)
      ),
    ),
  );
}
