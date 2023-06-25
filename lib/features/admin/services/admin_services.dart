import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:commercecart/constants/utils.dart';
import 'package:commercecart/models/product.dart';
import 'package:flutter/material.dart';

class AdminServices {
  void sellProduct({
    required BuildContext context,
    required List<File> images,
    required String name,
    required String description,
    required double price,
    required int quantity,
    required String category,
  }) async {
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
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }

  Future<List<String>> uploadImagesToCloudinary(
      BuildContext context, List<File> images, String productName) async {
    List<String> imageUrls = [];
    try {
      final cloudinary = CloudinaryPublic('dmk6cy00x', 'fti1dyhp');
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
}
