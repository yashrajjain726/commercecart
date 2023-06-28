import 'dart:convert';
import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:commercecart/constants/globals.dart';
import 'package:commercecart/constants/utils.dart';
import 'package:commercecart/features/auth/screens/auth_screen.dart';
import 'package:commercecart/features/auth/services/http_error_handler.dart';
import 'package:commercecart/models/product.dart';
import 'package:commercecart/providers/product_provider.dart';
import 'package:commercecart/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminServices {
  Future<void> addProduct({
    required BuildContext context,
    required List<File> images,
    required String name,
    required String description,
    required int price,
    required int quantity,
    required String category,
  }) async {
    final userProvider = context.read<UserProvider>();
    try {
      List<String> imageUrls =
          await uploadImagesToCloudinary(context, images, name);
      Product product = Product(
          name: name,
          description: description,
          price: price,
          quantity: quantity,
          images: imageUrls,
          category: category);

      http.Response response = await http.post(
          Uri.parse('${Globals.URI}/admin/add/product'),
          body: product.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token
          });
      httpErrorHandler(
          response: response,
          context: context,
          onSuccess: () async {
            context.read<ProductProvider>().addProduct(product);
            showSnackbar(context, 'Yay,Product Added Successfully ..!');
            Navigator.pop(context);
          });
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }

  Future<List<String>> uploadImagesToCloudinary(
      BuildContext context, List<File> images, String productName) async {
    List<String> imageUrls = [];
    try {
      final cloudinary = CloudinaryPublic('dmk6cy00x', 'nhjccefi');
      for (int i = 0; i < images.length; i++) {
        final response = await cloudinary.uploadFile(
            CloudinaryFile.fromFile(images[i].path, folder: productName));
        imageUrls.add(response.secureUrl);
      }
    } catch (e) {
      showSnackbar(context, e.toString());
    }
    return imageUrls;
  }

  Future<List<Product>> fetchAllProducts(BuildContext context) async {
    final userProvider = context.read<UserProvider>();
    List<Product> products = [];
    try {
      http.Response response = await http
          .get(Uri.parse('${Globals.URI}/admin/get/products'), headers: {
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

  Future<void> deleteProduct(
      BuildContext context, String id, VoidCallback onSuccess) async {
    final userProvider = context.read<UserProvider>();
    try {
      http.Response response =
          await http.post(Uri.parse('${Globals.URI}/admin/delete/product'),
              headers: {
                'Content-Type': 'application/json; charset=UTF-8',
                'x-auth-token': userProvider.user.token
              },
              body: jsonEncode({'id': id}));
      httpErrorHandler(
          response: response,
          context: context,
          onSuccess: () {
            onSuccess();
            showSnackbar(context, 'Product has been deleted successfully...');
          });
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }

  Future<void> logout(BuildContext context) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.setString(Globals.AUTHTOKEN, "");
      Navigator.pushNamedAndRemoveUntil(
          context, AuthScreen.routeName, (route) => false);
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }
}
