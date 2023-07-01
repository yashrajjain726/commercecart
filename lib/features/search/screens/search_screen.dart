import 'package:commercecart/constants/globals.dart';
import 'package:commercecart/features/home/widgets/address_box.dart';
import 'package:commercecart/features/search/services/search_services.dart';
import 'package:commercecart/features/search/widgets/search_product_result_card.dart';
import 'package:commercecart/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = '/search';
  final String query;
  const SearchScreen({super.key, required this.query});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Product>? products;
  final SearchServices searchServices = SearchServices();
  @override
  void initState() {
    super.initState();
    fetchSearchBasedProducts();
  }

  fetchSearchBasedProducts() async {
    products =
        await searchServices.fetchSearchBasedProducts(context, widget.query);
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
            title: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 42,
                    margin: const EdgeInsets.only(left: 15),
                    child: Material(
                      borderRadius: BorderRadius.circular(7),
                      elevation: 1,
                      child: TextFormField(
                        onFieldSubmitted: (value) => Navigator.pushNamed(
                            context, SearchScreen.routeName,
                            arguments: value),
                        decoration: const InputDecoration(
                            hintText: 'Search appliances, mobiles and ...',
                            hintStyle: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 17,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.only(top: 10),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7)),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7)),
                              borderSide:
                                  BorderSide(color: Colors.black38, width: 1),
                            ),
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(left: 6),
                              child: Icon(Icons.search,
                                  color: Colors.black, size: 23),
                            )),
                      ),
                    ),
                  ),
                ),
                Container(
                  color: Colors.transparent,
                  height: 42,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: const Icon(
                    Icons.mic,
                    color: Colors.white,
                    size: 25,
                  ),
                )
              ],
            )),
      ),
      body: products == null
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                AddressBox(),
                SizedBox(height: 10),
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
