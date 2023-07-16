import 'dart:convert';
import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import '../../../constants/globals.dart';
import '../../../constants/utils.dart';
import '../../../common/services/http_error_handler.dart';
import '../../../models/analytics.dart';
import '../../../models/orders.dart';
import '../../../models/product.dart';
import '../../../providers/product_provider.dart';
import '../../../providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AdminService {
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

  Future<List<Product>> fetchProductListed(BuildContext context) async {
    final userProvider = context.read<UserProvider>();
    List<Product> products = [];
    try {
      http.Response response =
          await http.get(Uri.parse('${Globals.URI}/admin/products'), headers: {
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

  Future<List<OrdersModel>> fetchAllOrdersReceived(BuildContext context) async {
    final userProvider = context.read<UserProvider>();
    final List<OrdersModel> orders = [];
    try {
      http.Response response = await http.get(
        Uri.parse('${Globals.URI}/admin/orders-received'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token
        },
      );
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
          });
    } catch (e) {
      showSnackbar(context, e.toString());
    }
    return orders;
  }

  Future<void> changeOrderStatus(
      {required BuildContext context,
      required OrdersModel order,
      required VoidCallback onSuccess}) async {
    final userProvider = context.read<UserProvider>();
    try {
      http.Response response =
          await http.post(Uri.parse('${Globals.URI}/admin/order/change-status'),
              headers: {
                'Content-Type': 'application/json; charset=UTF-8',
                'x-auth-token': userProvider.user.token
              },
              body: jsonEncode({'id': order.id}));

      print(response.body);
      httpErrorHandler(
          response: response,
          context: context,
          onSuccess: () {
            onSuccess();
            showSnackbar(
                context, 'Product status has been updated successfully..');
          });
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }

  Future<Map<String, dynamic>> getAdminAnalytics(
      {required BuildContext context}) async {
    final userProvider = context.read<UserProvider>();
    List<Analytics> sales = [];
    int totalEarning = 0;

    try {
      http.Response response = await http.get(
        Uri.parse('${Globals.URI}/admin/analytics/earning'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token
        },
      );

      print(response.body);
      httpErrorHandler(
          response: response,
          context: context,
          onSuccess: () {
            var json = jsonDecode(response.body);
            totalEarning = json['totalEarning'];
            sales = [
              Analytics(label: 'Mobiles', totalEarning: json['mobileEarnings']),
              Analytics(
                  label: 'Essentials',
                  totalEarning: json['essentialsEarnings']),
              Analytics(
                  label: 'Appliances',
                  totalEarning: json['appliancesEarnings']),
              Analytics(label: 'Books', totalEarning: json['booksEarnings']),
              Analytics(
                  label: 'Fashion', totalEarning: json['fashionEarnings']),
            ];
          });
    } catch (e) {
      showSnackbar(context, e.toString());
    }
    return {
      'sales': sales,
      'totalEarning': totalEarning,
    };
  }
}
