// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:commercecart/common/widgets/admin_bottom_bar.dart';
import 'package:commercecart/common/widgets/user_bottombar.dart';
import 'package:commercecart/features/auth/screens/login_screen.dart';
import 'package:commercecart/features/auth/services/auth_service.dart';
import 'package:commercecart/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    navigationCondition();
  }

  navigationCondition() async {
    await authService.getUserData(context);

    Timer(const Duration(seconds: 2), () {
      context.read<UserProvider>().user.token.isNotEmpty
          ? (context.read<UserProvider>().user.type == "user")
              ? Navigator.pushReplacementNamed(context, UserBottomBar.routeName)
              : (context.read<UserProvider>().user.type == "admin")
                  ? Navigator.pushReplacementNamed(
                      context, AdminBottomBar.routeName)
                  : Navigator.pushReplacementNamed(
                      context, LoginScreen.routeName)
          : Navigator.pushReplacementNamed(context, LoginScreen.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset('assets/splash_logo.json', height: 500),
            const Text(
              'Commercecart',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Text(
              'An opensource ecommerce app',
              style: TextStyle(fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}
