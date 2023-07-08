import 'dart:convert';

import 'package:commercecart/constants/globals.dart';
import 'package:commercecart/constants/utils.dart';
import 'package:commercecart/features/auth/services/http_error_handler.dart';
import 'package:commercecart/models/user.dart';
import 'package:commercecart/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class CartServices {
  void removeProductfromCart(
      {required BuildContext context, required String productId}) async {
    final userProvider = context.read<UserProvider>();

    try {
      http.Response response = await http.delete(
        Uri.parse('${Globals.URI}/api/product/remove-from-cart/$productId'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token
        },
      );
      print(response);
      httpErrorHandler(
          response: response,
          context: context,
          onSuccess: () {
            User user = userProvider.user
                .copyWith(cartList: jsonDecode(response.body)['cart']);
            userProvider.setUserfromModel(user);
          });
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }
}
