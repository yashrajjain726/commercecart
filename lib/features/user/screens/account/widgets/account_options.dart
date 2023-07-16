import '../../../../auth/services/auth_service.dart';

import 'account_option_button.dart';
import 'package:flutter/material.dart';

class AccountOptions extends StatefulWidget {
  const AccountOptions({super.key});

  @override
  State<AccountOptions> createState() => _AccountOptionsState();
}

class _AccountOptionsState extends State<AccountOptions> {
  final AuthService authService = AuthService();
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
            AccountOptionButton(
                onPressed: () => authService.logout(context),
                optionText: 'Log Out'),
            AccountOptionButton(onPressed: () {}, optionText: 'Wishlist'),
          ],
        )
      ],
    );
  }
}
