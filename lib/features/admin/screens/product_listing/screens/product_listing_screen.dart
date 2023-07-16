import 'package:commercecart/features/admin/screens/product_listing/widgets/product_listing_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../constants/globals.dart';
import '../../../../../providers/product_provider.dart';
import '../../../services/admin_service.dart';
import '../../add_product/screens/add_product_screen.dart';

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
                  : GridView.builder(
                      itemCount: products.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                      itemBuilder: (context, index) {
                        final product = products[index];

                        return ProductListingItem(
                            product: product, index: index);
                      },
                    ),
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
