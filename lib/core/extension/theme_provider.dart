import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/colors_constants.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;

  bool get isDarkMode {
    if (themeMode == ThemeMode.system) {
      final brightness = SchedulerBinding.instance.window.platformBrightness;
      return brightness == Brightness.dark;
    } else {
      return themeMode == ThemeMode.dark;
    }
  }

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

ColorScheme _customColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: ColorConstants.instance.jungleGreen,
  onPrimary: ColorConstants.instance.blueRibbon,
  background: ColorConstants.instance.white,
  onBackground: ColorConstants.instance.white,
  secondary: ColorConstants.instance.gray,
  onSecondary: ColorConstants.instance.gray,
  error: ColorConstants.instance.gray,
  onError: ColorConstants.instance.gray,
  surface: ColorConstants.instance.gray,
  onSurface: ColorConstants.instance.gray,
);

String fontFamily = GoogleFonts.inter().fontFamily!;

class MyThemes {
  static final lightTheme = ThemeData(
    fontFamily: fontFamily,
    scaffoldBackgroundColor: _customColorScheme.background,
    primaryColor: _customColorScheme.primary,
    focusColor: _customColorScheme.secondary,
    colorScheme: _customColorScheme,
    textTheme: TextTheme(
      headline1: TextStyle(
        fontSize: 22.sp,
        color: ColorConstants.instance.black,
        fontWeight: FontWeight.w600,
      ),
      headline2: TextStyle(
        fontSize: 20.sp,
        color: ColorConstants.instance.white,
        fontWeight: FontWeight.w700,
      ),
      headline3: TextStyle(
        fontSize: 18.sp,
        color: ColorConstants.instance.white,
        fontWeight: FontWeight.w500,
      ),
      headline4: TextStyle(
        fontSize: 16.sp,
        color: ColorConstants.instance.jungleGreen,
        fontWeight: FontWeight.w700,
      ),
      headline5: TextStyle(
        fontSize: 14.sp,
        color: ColorConstants.instance.white,
        fontWeight: FontWeight.w600,
      ),
      headline6: TextStyle(
        fontSize: 12.sp,
        color: ColorConstants.instance.black,
        fontWeight: FontWeight.w300,
      ),
    ),
  );

  static final darkTheme = ThemeData(
    fontFamily: fontFamily,
    scaffoldBackgroundColor: _customColorScheme.background,
    primaryColor: _customColorScheme.primary,
    focusColor: _customColorScheme.secondary,
    colorScheme: _customColorScheme,
    textTheme: TextTheme(
      headline1: TextStyle(
        fontSize: 18.sp,
        color: ColorConstants.instance.blueRibbon,
        fontWeight: FontWeight.w500,
      ),
      headline2: TextStyle(
        fontSize: 20.sp,
        color: ColorConstants.instance.white,
        fontWeight: FontWeight.w700,
      ),
      headline3: TextStyle(
        fontSize: 12.sp,
        color: ColorConstants.instance.gray,
        fontWeight: FontWeight.w300,
      ),
      headline4: TextStyle(
        fontSize: 14.sp,
        color: ColorConstants.instance.blueRibbon,
        fontWeight: FontWeight.w500,
      ),
      headline5: TextStyle(
        fontSize: 14.sp,
        color: ColorConstants.instance.white,
        fontWeight: FontWeight.w500,
      ),
      headline6: TextStyle(
        fontSize: 11.sp,
        color: ColorConstants.instance.gray,
        fontWeight: FontWeight.w400,
      ),
    ),
  );
}
