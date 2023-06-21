import 'package:flutter/material.dart';

class Globals {
  static const URI = 'http://192.168.1.5:3000';

  // COLORS
  static const appBarGradient = LinearGradient(
    colors: [
      Color.fromARGB(255, 29, 21, 192),
      Color.fromARGB(255, 50, 21, 216),
    ],
    stops: [0.5, 1.0],
  );

  static const secondaryColor = Color.fromARGB(255, 50, 21, 216);
  static const backgroundColor = Colors.white;
  static const Color greyBackgroundCOlor = Color(0xffebecee);
  static var selectedNavBarColor = const Color.fromARGB(255, 29, 36, 128);
  static const unselectedNavBarColor = Colors.black87;

  // SHARED PREFERNCES
  static const AUTHTOKEN = 'x-auth-token';
}
