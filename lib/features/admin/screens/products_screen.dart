import 'package:commercecart/constants/globals.dart';
import 'package:commercecart/features/admin/screens/add_product_screen.dart';
import 'package:commercecart/features/admin/services/admin_services.dart';
import 'package:commercecart/features/admin/widgets/product_item.dart';
import 'package:commercecart/models/product.dart';
import 'package:flutter/material.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  List<Product>? products;
  final AdminServices adminServices = AdminServices();
  @override
  void initState() {
    super.initState();
    fetchAllProducts();
  }

  fetchAllProducts() async {
    products = await adminServices.fetchAllProducts(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return products == null
        ? const Center(child: CircularProgressIndicator())
        : RefreshIndicator(
            onRefresh: () => fetchAllProducts(),
            child: Scaffold(
              body: products!.isEmpty
                  ? const Center(
                      child: Text('Products'),
                    )
                  : ProductItem(products: products),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              floatingActionButton: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, AddProductScreen.routeName);
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 30)
                      .copyWith(top: 10),
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Globals.secondaryColor,
                      borderRadius: BorderRadius.circular(50)),
                  child: const Text(
                    'Add Products',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  ),
                ),
              ),
            ),
          );
  }
}
