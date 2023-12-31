import 'package:flutter/material.dart';

class ColorConstants {
  static final ColorConstants _instance = ColorConstants._init();
  static ColorConstants get instance => ColorConstants._instance;

  Color blueRibbon = const Color(0xff006AFF);
  Color white = const Color(0xffFFFFFF);
  Color gray = const Color(0xff908e8e);
  Color jungleGreen = const Color(0xff25AE87);
  Color black = const Color(0xff000000);
  Color gallery = const Color(0xffEFEFEF);
  Color texasRose = const Color(0xffFDAE57);
  Color codGray = const Color(0xff090909);
  Color transparentBlack = const Color.fromRGBO(0, 0, 0, 0.4);
  Color tealAccent = const Color.fromARGB(255, 29, 233, 182);
  Color blueAccent = const Color.fromARGB(255, 68, 138, 255);
  Color red = const Color.fromARGB(255, 244, 67, 54);

  ColorConstants._init();
}
