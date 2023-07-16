import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../constants/globals.dart';
import '../../../../../providers/product_provider.dart';
import '../../../services/admin_service.dart';
import '../../add_product/screens/add_product_screen.dart';
import '../widgets/product_item.dart';

class ProductListingScreen extends StatefulWidget {
  const ProductListingScreen({super.key});

  @override
  State<ProductListingScreen> createState() => _ProductListingScreenState();
}

class _ProductListingScreenState extends State<ProductListingScreen> {
  final AdminService adminServices = AdminService();
  @override
  void initState() {
    super.initState();
    fetchAllProducts();
  }

  fetchAllProducts() async {
    context.read<ProductProvider>().products =
        await adminServices.fetchProductListed(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final products = context.watch<ProductProvider>().products;
    return products == null
        ? const Center(child: CircularProgressIndicator())
        : RefreshIndicator(
            onRefresh: () => fetchAllProducts(),
            child: Scaffold(
              body: products.isEmpty
                  ? const Center(
                      child: Text('No, Products added yet.'),
                    )
                  : const ProductListingItem(),
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
