import 'package:flutter/material.dart';

class DarkTheme {
  static ThemeData darkTheme() => ThemeData(
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: Colors.grey[800],
            selectedIconTheme: const IconThemeData(color: Colors.black)),
        primarySwatch: const MaterialColor(0x73000000, <int, Color>{
          50: Color(0x1F000000),
          100: Color(0x42000000),
          200: Color(0x42000000),
          300: Color(0x61000000),
          400: Color(0x61000000),
          500: Color(0x73000000),
          600: Color(0x73000000),
          700: Color(0x8A000000),
          800: Color(0xDD000000),
          900: Color(0xFF000000),
        }),
        primaryColor: Colors.grey[800],
        accentColor: Colors.grey[800],
        scaffoldBackgroundColor: Colors.grey[800],
        textTheme: const TextTheme(
          subtitle1: TextStyle(color: Colors.white70),
          subtitle2: TextStyle(color: Colors.white70),
          bodyText1: TextStyle(color: Colors.white70),
          bodyText2: TextStyle(color: Colors.white70),
          
        ),
        // primaryTextTheme: Theme.of(context)
        //     .textTheme
        //     .apply(bodyColor: Colors.white70, displayColor: Colors.greenAccent),
        // textTheme: Theme.of(context)
        //     .textTheme
        //     .apply(bodyColor: Colors.white, displayColor: Colors.teal[200]),
      );
}
