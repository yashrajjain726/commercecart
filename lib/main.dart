import 'package:commercecart/constants/globals.dart';
import 'package:commercecart/constants/routes.dart';
import 'package:commercecart/features/auth/screens/auth_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'CommerceCart',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            colorScheme:
                const ColorScheme.light(primary: Globals.secondaryColor),
            scaffoldBackgroundColor: Globals.backgroundColor,
            appBarTheme: const AppBarTheme(
                elevation: 0, iconTheme: IconThemeData(color: Colors.black))),
        onGenerateRoute: (settings) => onGenerateRoute(settings),
        home: const AuthScreen());
  }
}
