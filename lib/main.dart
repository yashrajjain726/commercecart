import 'package:commercecart/common/widgets/admin_bottom_bar.dart';
import 'package:commercecart/common/widgets/user_bottombar.dart';
import 'package:commercecart/constants/globals.dart';
import 'package:commercecart/constants/routes.dart';
import 'package:commercecart/features/auth/screens/auth_screen.dart';
import 'package:commercecart/features/auth/services/auth_service.dart';
import 'package:commercecart/providers/product_provider.dart';
import 'package:commercecart/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => UserProvider()),
    ChangeNotifierProvider(create: (_) => ProductProvider())
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    authService.getUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CommerceCart',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: const ColorScheme.light(primary: Globals.secondaryColor),
          scaffoldBackgroundColor: Globals.backgroundColor,
          appBarTheme: const AppBarTheme(
              elevation: 0, iconTheme: IconThemeData(color: Colors.white))),
      onGenerateRoute: (settings) => onGenerateRoute(settings),
      home: context.watch<UserProvider>().user.token.isNotEmpty
          ? (context.watch<UserProvider>().user.type == "user")
              ? const UserBottomBar()
              : (context.watch<UserProvider>().user.type == "admin")
                  ? const AdminBottomBar()
                  : null
          : const AuthScreen(),
    );
  }
}
