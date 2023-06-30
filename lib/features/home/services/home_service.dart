import 'dart:convert';

import 'package:commercecart/constants/globals.dart';
import 'package:commercecart/constants/utils.dart';
import 'package:commercecart/features/auth/services/http_error_handler.dart';
import 'package:commercecart/models/product.dart';
import 'package:commercecart/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class HomeService {
  Future<List<Product>> fetchCategoryBasedProducts(
      BuildContext context, String category) async {
    final userProvider = context.read<UserProvider>();
    List<Product> products = [];
    try {
      http.Response response = await http.get(
          Uri.parse('${Globals.URI}/api/get/products?category=$category'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token
          });
      print(response);
      httpErrorHandler(
          response: response,
          context: context,
          onSuccess: () {
            final json = jsonDecode(response.body);
            for (int i = 0; i < json.length; i++) {
              products.add(Product.fromJson(jsonEncode(json[i])));
            }
          });
    } catch (e) {
      showSnackbar(context, e.toString());
    }
    return products;
  }
}
