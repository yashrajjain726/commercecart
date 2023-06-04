import 'package:flutter/material.dart';

class NoPageFound extends StatelessWidget {
  const NoPageFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Sorry, the page wasn\'t found on database'),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Refresh'),
            )
          ],
        ),
      ),
    );
  }
}
