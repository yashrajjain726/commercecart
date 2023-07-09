import 'dart:convert';

import 'package:commercecart/constants/globals.dart';
import 'package:commercecart/constants/utils.dart';
import 'package:commercecart/features/auth/services/http_error_handler.dart';
import 'package:commercecart/models/user.dart';
import 'package:commercecart/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class AddressService {
  updateAddress(
      {required BuildContext context, required String address}) async {
    final userProvider = context.read<UserProvider>();

    try {
      http.Response response =
          await http.post(Uri.parse('${Globals.URI}/api/user/update-address'),
              headers: {
                'Content-Type': 'application/json; charset=UTF-8',
                'x-auth-token': userProvider.user.token
              },
              body: jsonEncode({'address': address}));
      print(response);
      httpErrorHandler(
          response: response,
          context: context,
          onSuccess: () {
            User user = userProvider.user
                .copyWith(address: jsonDecode(response.body)['address']);
            userProvider.setUserfromModel(user);
            Navigator.pop(context);
          });
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }

  void placeOrder(
      {required BuildContext context,
      required String address,
      required double totalPrice}) async {
    final userProvider = context.read<UserProvider>();

    try {
      http.Response response = await http.post(
          Uri.parse('${Globals.URI}/api/user/order-product'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token
          },
          body: jsonEncode({
            'cart': userProvider.user.cartList,
            'address': address,
            'totalPrice': totalPrice
          }));
      print(response);
      httpErrorHandler(
          response: response,
          context: context,
          onSuccess: () {
            User user = userProvider.user.copyWith(cartList: []);
            userProvider.setUserfromModel(user);
            showSnackbar(context, 'Your order has been placed successfully..');
          });
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }
}
