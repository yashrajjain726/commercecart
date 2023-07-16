// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:commercecart/features/user/services/home_service.dart';
import 'package:commercecart/features/user/screens/product/screens/product_detail_screen.dart';
import 'package:commercecart/models/product.dart';
import 'package:flutter/material.dart';

import 'package:commercecart/constants/globals.dart';

class CategoryScreen extends StatefulWidget {
  static const String routeName = '/category';
  final String category;
  const CategoryScreen({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final HomeService homeService = HomeService();
  List<Product>? products;
  @override
  void initState() {
    super.initState();
    fetchCategoryBasedProducts();
  }

  fetchCategoryBasedProducts() async {
    products =
        await homeService.fetchCategoryBasedProducts(context, widget.category);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(gradient: Globals.appBarGradient),
            ),
            title: Text(
              widget.category,
              style: const TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
            )),
      ),
      body: products == null
          ? const Center(child: CircularProgressIndicator())
          : products!.isEmpty
              ? Center(
                  child: Text('No products found in ${widget.category}..'),
                )
              : Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: Text(
                        'Keep shopping for ${widget.category}',
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                    SizedBox(
                      height: 200,
                      child: GridView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.only(left: 15),
                        itemCount: products!.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 1,
                                childAspectRatio: 1.4,
                                mainAxisSpacing: 10),
                        itemBuilder: (context, index) {
                          final product = products![index];
                          return GestureDetector(
                            onTap: () => Navigator.pushNamed(
                                context, ProductDetailScreen.routeName,
                                arguments: product),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 150,
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.black12,
                                        width: 0.5,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Image.network(product.images[0]),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Container(
                                  alignment: Alignment.topLeft,
                                  padding: const EdgeInsets.only(
                                      left: 0, top: 5, right: 15),
                                  child: Text(
                                    product.name,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
    );
  }
}
