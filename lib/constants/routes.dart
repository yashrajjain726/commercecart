import 'package:commercecart/common/widgets/bottombar.dart';
import 'package:commercecart/features/auth/screens/auth_screen.dart';
import 'package:commercecart/features/home/screens/home_screen.dart';
import 'package:commercecart/features/no_page_found.dart';
import 'package:flutter/material.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AuthScreen.routeName:
      return buildRoute(screen: const AuthScreen());
    case HomeScreen.routeName:
      return buildRoute(screen: const HomeScreen());
    case BottomBar.routeName:
      return buildRoute(screen: const BottomBar());
    default:
      return buildRoute(screen: const NoPageFound());
  }
}

buildRoute({required Widget screen}) {
  return MaterialPageRoute(builder: (_) => screen);
}
