import 'package:commercecart/common/widgets/custom_button.dart';
import 'package:commercecart/constants/globals.dart';
import 'package:commercecart/features/cart/widgets/card_item.dart';
import 'package:commercecart/features/cart/widgets/cart_subtotal.dart';
import 'package:commercecart/features/home/widgets/address_box.dart';
import 'package:commercecart/features/search/screens/search_screen.dart';
import 'package:commercecart/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  static const routeName = '/cart';
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>().user;
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
              flexibleSpace: Container(
                decoration:
                    const BoxDecoration(gradient: Globals.appBarGradient),
              ),
              title: const Text('Your Cart')),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const AddressBox(),
              const CartSubTotal(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomButton(
                    text: Text(
                        'Proceed to Buy ${userProvider.cartList.length} items'),
                    onPressed: () {}),
              ),
              const SizedBox(height: 15),
              const Divider(thickness: 1),
              const SizedBox(height: 15),
              ListView.builder(
                shrinkWrap: true,
                itemCount: userProvider.cartList.length,
                itemBuilder: (BuildContext context, int index) {
                  return CartItem(index: index);
                },
              )
            ],
          ),
        ));
  }
}
