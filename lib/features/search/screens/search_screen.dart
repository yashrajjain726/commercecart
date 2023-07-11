import 'package:commercecart/common/widgets/appbar_search_widget.dart';
import 'package:commercecart/constants/globals.dart';
import 'package:commercecart/features/home/widgets/address_box.dart';
import 'package:commercecart/features/search/widgets/search_product_result_card.dart';
import 'package:commercecart/models/product.dart';
import 'package:commercecart/services/user_service.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = '/search';
  final String query;
  const SearchScreen({super.key, required this.query});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Product>? products;
  final UserService userService = UserService();
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchSearchBasedProducts();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  fetchSearchBasedProducts() async {
    products =
        await userService.fetchSearchBasedProducts(context, widget.query);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
              flexibleSpace: Container(
                decoration:
                    const BoxDecoration(gradient: Globals.appBarGradient),
              ),
              title: const AppBarSearchWidget())),
      body: products == null
          ? const Center(child: CircularProgressIndicator())
          : products!.isEmpty
              ? const Center(
                  child: Text('No search result found in the database'),
                )
              : Column(
                  children: [
                    const AddressBox(),
                    const SizedBox(height: 10),
                    Expanded(
                        child: ListView.builder(
                      itemCount: products!.length,
                      itemBuilder: (context, index) {
                        return SearchProductResultCard(
                          product: products![index],
                        );
                      },
                    ))
                  ],
                ),
    );
  }
}
