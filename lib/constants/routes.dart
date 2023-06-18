import 'package:commercecart/features/auth/screens/auth_screen.dart';
import 'package:commercecart/features/home/screens/home_screen.dart';
import 'package:commercecart/features/no_page_found.dart';
import 'package:flutter/material.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AuthScreen.routeName:
      return buildRoute(screen: AuthScreen());
    case HomeScreen.routeName:
      return buildRoute(screen: HomeScreen());
    default:
      return buildRoute(screen: NoPageFound());
  }
}

buildRoute({required Widget screen}) {
  return MaterialPageRoute(builder: (_) => screen);
}
