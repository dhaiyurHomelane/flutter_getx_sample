import 'package:flutter/material.dart';

class Themes {
  final ThemeData darkTheme = ThemeData(
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: Colors.grey[800],
      brightness: Brightness.dark,
      primary: Colors.deepPurpleAccent,
    ),
    brightness: Brightness.dark,
    backgroundColor: Colors.grey[800],
    primaryColor: Colors.white,
    appBarTheme: const AppBarTheme().copyWith(
        actionsIconTheme: const IconThemeData(color: Colors.white),
        iconTheme: const IconThemeData(color: Colors.white)),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold,color: Colors.white),
      bodyText2: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400,color: Colors.white),
      caption: TextStyle(fontSize: 14.0, color: Colors.white),
    )
  );

  final ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: Colors.white,
      brightness: Brightness.light,
      primary: Colors.pink,
    ),
    brightness: Brightness.light,
    primaryColor: Colors.pink,
    textTheme: const TextTheme(
      headlineLarge: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold,color: Colors.black),
      bodyText2: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400,color: Colors.black),
      caption: TextStyle(fontSize: 14.0, color: Colors.white),
    ),
    appBarTheme: const AppBarTheme().copyWith(
        actionsIconTheme: const IconThemeData(color: Colors.black),
        iconTheme: const IconThemeData(color: Colors.black),
        titleTextStyle: const TextStyle(color: Colors.black)),
    backgroundColor: Colors.white,
  );
}
