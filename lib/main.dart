import 'package:commercecart/constants/globals.dart';
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
          colorScheme: const ColorScheme.light(primary: Globals.secondaryColor),
          scaffoldBackgroundColor: Globals.backgroundColor,
          appBarTheme: const AppBarTheme(
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black),
          )),
      home: Scaffold(
          appBar: AppBar(
            title: const Text("Hello"),
          ),
          body: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {}, child: const Text("Demo Button")),
              const Text(
                'Demo Text',
              ),
            ],
          ))),
    );
  }
}
