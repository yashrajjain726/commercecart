import 'dart:convert';
import 'package:commercecart/common/ui_widgets/loader.dart';

import '../../../constants/globals.dart';
import '../../../constants/utils.dart';
import '../../../common/services/http_error_handler.dart';
import '../../../models/orders.dart';
import '../../../models/product.dart';
import '../../../models/user.dart';
import '../../../providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class UserService {
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
            User user = userProvider.user.copyWith(
              address: jsonDecode(response.body)['address'],
            );
            userProvider.setUserfromModel(user);
            Navigator.pop(context);
          });
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }

  updateUserData(
      {required BuildContext context,
      required String address,
      required String name}) async {
    final userProvider = context.read<UserProvider>();
    Loader().showLoadingDialog(context);
    try {
      http.Response response =
          await http.post(Uri.parse('${Globals.URI}/api/user/update'),
              headers: {
                'Content-Type': 'application/json; charset=UTF-8',
                'x-auth-token': userProvider.user.token
              },
              body: jsonEncode({'address': address, 'name': name}));
      print(response);
      httpErrorHandler(
          response: response,
          context: context,
          onSuccess: () {
            Loader().closeLoadingDialog(context);
            User user = userProvider.user.copyWith(
                address: jsonDecode(response.body)['address'],
                name: jsonDecode(response.body)['name']);
            userProvider.setUserfromModel(user);
            Navigator.pop(context);
          });
    } catch (e) {
      Loader().closeLoadingDialog(context);
      showSnackbar(context, e.toString());
    }
  }

  Future<List<Product>> fetchSearchBasedProducts(
      BuildContext context, String query) async {
    final userProvider = context.read<UserProvider>();
    List<Product> products = [];
    try {
      http.Response response = await http.get(
          Uri.parse('${Globals.URI}/api/products/search/$query'),
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

  Future<List<OrdersModel>> fetchUserOrderedProducts(
      {required BuildContext context}) async {
    final List<OrdersModel> orders = [];
    final userProvider = context.read<UserProvider>().user;
    final userId = userProvider.id;
    try {
      http.Response response =
          await http.get(Uri.parse('${Globals.URI}/api/user/orders'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.token
      });
      print(response.body);
      httpErrorHandler(
        response: response,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(response.body).length; i++) {
            orders.add(
              OrdersModel.fromJson(
                jsonEncode(
                  jsonDecode(response.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      showSnackbar(context, e.toString());
    }
    return orders;
  }
}
