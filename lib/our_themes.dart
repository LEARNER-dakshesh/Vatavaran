import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import 'consts/colors.dart';

class CustomThemes{
  static final lightTheme=ThemeData(
    fontFamily: "poppins",
    cardColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Vx.gray800,
    iconTheme: IconThemeData(
      color: Vx.gray800,
    ),
  );
  static final darkTheme=ThemeData(
    fontFamily: "poppins",
    scaffoldBackgroundColor: bgColor,
    primaryColor: Colors.white,
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
  );
}