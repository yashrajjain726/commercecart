import 'package:commercecart/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';

import 'package:commercecart/constants/globals.dart';
import 'package:commercecart/features/address/screens/address_screen.dart';
import 'package:commercecart/providers/user_provider.dart';

class ConfirmAddressScreen extends StatefulWidget {
  final double amount;
  static const routeName = '/confirm-address';
  const ConfirmAddressScreen({
    Key? key,
    required this.amount,
  }) : super(key: key);

  @override
  State<ConfirmAddressScreen> createState() => _ConfirmAddressScreenState();
}

class _ConfirmAddressScreenState extends State<ConfirmAddressScreen> {
  final UserService userService = UserService();
  List<PaymentItem> paymentItems = [];
  final Future<PaymentConfiguration> _applePayConfigFuture =
      PaymentConfiguration.fromAsset('applepay.json');
  @override
  void initState() {
    super.initState();
    paymentItems = [
      PaymentItem(
          amount: widget.amount.toString(),
          label: 'Total Amount',
          status: PaymentItemStatus.final_price)
    ];
  }

  void onPaymentResult(paymentResult) {
    userService.placeOrder(
        context: context,
        address: context.read<UserProvider>().user.address,
        totalPrice: widget.amount);
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>().user;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(gradient: Globals.appBarGradient),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Confirm Address',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                        flex: 3,
                        child: Text(
                          userProvider.address,
                          style: const TextStyle(fontSize: 18),
                        )),
                    Expanded(
                        flex: 1,
                        child: IconButton(
                          icon: const Icon(
                            Icons.edit,
                            size: 18,
                          ),
                          onPressed: () {
                            Navigator.pushNamed(
                                context, AddressScreen.routeName);
                          },
                        )),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text('Total Amount: ${widget.amount}'),
            FutureBuilder<PaymentConfiguration>(
                future: _applePayConfigFuture,
                builder: (context, snapshot) => snapshot.hasData
                    ? ApplePayButton(
                        paymentConfiguration: snapshot.data!,
                        paymentItems: paymentItems,
                        type: ApplePayButtonType.buy,
                        style: ApplePayButtonStyle.black,
                        width: double.infinity,
                        height: 40,
                        margin: const EdgeInsets.only(top: 15.0),
                        onPaymentResult: onPaymentResult,
                        loadingIndicator: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : const SizedBox.shrink()),
          ],
        ),
      ),
    );
  }
}
