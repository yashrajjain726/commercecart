import 'dart:convert';

import 'package:commercecart/constants/globals.dart';
import 'package:commercecart/constants/utils.dart';
import 'package:commercecart/features/auth/services/http_error_handler.dart';
import 'package:commercecart/models/product.dart';
import 'package:commercecart/models/user.dart';
import 'package:commercecart/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class ProductDetailService {
  void addProductToCart(
      {required BuildContext context, required String productId}) async {
    final userProvider = context.read<UserProvider>();

    try {
      http.Response response =
          await http.post(Uri.parse('${Globals.URI}/api/user/add-to-cart'),
              headers: {
                'Content-Type': 'application/json; charset=UTF-8',
                'x-auth-token': userProvider.user.token
              },
              body: jsonEncode({'id': productId}));
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

  void rateProduct(
      {required BuildContext context,
      required Product product,
      required double rating}) async {
    final userProvider = context.read<UserProvider>();

    try {
      http.Response response =
          await http.post(Uri.parse('${Globals.URI}/api/product/rating'),
              headers: {
                'Content-Type': 'application/json; charset=UTF-8',
                'x-auth-token': userProvider.user.token
              },
              body: jsonEncode({
                'id': product.id,
                'rating': rating,
              }));
      print(response);
      httpErrorHandler(
          response: response,
          context: context,
          onSuccess: () {
            showSnackbar(context, 'Product rating updated successfully..');
          });
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }
}
