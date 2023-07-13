import 'package:commercecart/constants/globals.dart';
import 'package:commercecart/constants/utils.dart';
import 'package:commercecart/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountGreetingBar extends StatelessWidget {
  const AccountGreetingBar({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    return Container(
      decoration: const BoxDecoration(gradient: Globals.appBarGradient),
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
                text: 'Hello, ',
                style: const TextStyle(fontSize: 22),
                children: [
                  TextSpan(
                      text: uppercaseFirstLetter(user.name),
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ))
                ]),
          ),
        ],
      ),
    );
  }
}
