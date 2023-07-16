import '../models/product.dart';
import 'package:flutter/material.dart';

class ProductProvider extends ChangeNotifier {
  List<Product> products = [];

  getProducts() {
    return products;
  }

  addProduct(Product product) {
    products.add(product);
    notifyListeners();
  }

  deleteProduct(int index) {
    products.removeAt(index);
    notifyListeners();
  }
}
