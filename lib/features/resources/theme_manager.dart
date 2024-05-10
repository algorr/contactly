import 'package:flutter/material.dart';
import 'index.dart';

ThemeData getAppTheme() {
  return ThemeData(
    useMaterial3: true,
// Main colors of the application
    primaryColor: ColorManager.primary,
    disabledColor: ColorManager.grey,
    splashColor: ColorManager.primary,
    brightness: Brightness.dark,

    // Progress Indicator
    progressIndicatorTheme:
        ProgressIndicatorThemeData(color: ColorManager.black),

    // CardView Theme
    cardTheme: CardTheme(
      color: ColorManager.white,
      shadowColor: ColorManager.grey,
      elevation: AppSize.s4,
    ),

    iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(iconColor: MaterialStateProperty.all(Colors.white))),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: ColorManager.primary, elevation: AppSize.s10),

    // AppBar Theme
    appBarTheme: AppBarTheme(
      backgroundColor: ColorManager.primary,
      actionsIconTheme: IconThemeData(color: ColorManager.blue),
      iconTheme: IconThemeData(color: ColorManager.blue),
    ),

    // Button Theme
    buttonTheme: ButtonThemeData(
      shape: const StadiumBorder(),
      disabledColor: ColorManager.grey,
      buttonColor: ColorManager.primary,
      splashColor: ColorManager.primary,
    ),

    // Elevated Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: getRegularTextStyle(
          color: ColorManager.white,
        ),
        backgroundColor: ColorManager.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            AppSize.s12,
          ),
        ),
      ),
    ),

    // TextTheme
    textTheme: TextTheme(
      displayLarge: getBoldTextStyle(
        color: ColorManager.black,
        fontSize: FontSize.s24,
      ),
      titleMedium: getMediumTextStyle(
        color: ColorManager.black,
        fontSize: FontSize.s16,
      ),
      bodySmall: getRegularTextStyle(
        color: ColorManager.blue,
        fontSize: FontSize.s16,
      ),
      bodyLarge: getLargeTextStyle(
        color: ColorManager.black,
      ),
      labelLarge:
          getLargeTextStyle(color: ColorManager.black, fontSize: FontSize.s40),
      labelMedium: getLargeTextStyle(
          color: ColorManager.primary, fontSize: FontSize.s22),
      titleLarge:
          getLargeTextStyle(color: ColorManager.white, fontSize: FontSize.s16),
      headlineMedium: getLargeTextStyle(
          color: ColorManager.primary, fontSize: FontSize.s18),
    ),

    //Input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: getRegularTextStyle(
        color: ColorManager.grey,
      ),
      labelStyle: getRegularTextStyle(color: ColorManager.primary),
      errorStyle: getRegularTextStyle(color: ColorManager.primary),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide.none,
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide.none,
      ),
      errorBorder: const OutlineInputBorder(
        borderSide: BorderSide.none,
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderSide: BorderSide.none,
      ),
    ),
  );
}
