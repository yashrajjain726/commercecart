import 'package:commercecart/constants/globals.dart';
import 'package:commercecart/features/address/screens/address_screen.dart';
import 'package:commercecart/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddressBox extends StatelessWidget {
  const AddressBox({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, AddressScreen.routeName),
      child: Container(
        height: 40,
        decoration: const BoxDecoration(gradient: Globals.appBarGradient),
        padding: const EdgeInsets.only(left: 10),
        child: Row(
          children: [
            const Icon(
              Icons.location_on_outlined,
              color: Colors.white,
              size: 20,
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Text(
                'Delivery to ${user.name} - ${user.address}',
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    overflow: TextOverflow.ellipsis),
              ),
            )),
            const Padding(
              padding: EdgeInsets.only(left: 5, top: 2),
              child: Icon(Icons.arrow_drop_down_outlined,
                  size: 18, color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
