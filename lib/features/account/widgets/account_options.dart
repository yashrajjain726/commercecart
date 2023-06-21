import 'package:commercecart/features/account/widgets/account_option_button.dart';
import 'package:flutter/material.dart';

class AccountOptions extends StatelessWidget {
  const AccountOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            AccountOptionButton(onPressed: () {}, optionText: 'Your Orders'),
            AccountOptionButton(onPressed: () {}, optionText: 'Turn Seller'),
          ],
        ),
        SizedBox(height: 10),
        Row(
          children: [
            AccountOptionButton(onPressed: () {}, optionText: 'Log Out'),
            AccountOptionButton(onPressed: () {}, optionText: 'Wishlist'),
          ],
        )
      ],
    );
  }
}
