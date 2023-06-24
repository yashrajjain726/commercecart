import 'package:commercecart/common/widgets/user_bottombar.dart';
import 'package:commercecart/features/admin/screens/add_product_screen.dart';
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
    case UserBottomBar.routeName:
      return buildRoute(screen: const UserBottomBar());
    case AddProductScreen.routeName:
      return buildRoute(screen: const AddProductScreen());
    default:
      return buildRoute(screen: const NoPageFound());
  }
}

buildRoute({required Widget screen}) {
  return MaterialPageRoute(builder: (_) => screen);
}
