export 'app_theme.dart';
import 'package:flutter/material.dart';

import 'app_text_theme.dart';



final ThemeData appThemeData = ThemeData(
  primaryColor: Colors.purple,
  primaryColorDark: Colors.purple[800],
  accentColor: Colors.purpleAccent,
  splashColor: Colors.purpleAccent,
  highlightColor: Colors.purple,
  fontFamily: 'Georgia',
  textTheme: appTextTheme,
);
