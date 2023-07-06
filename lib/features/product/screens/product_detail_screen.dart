import 'package:carousel_slider/carousel_slider.dart';
import 'package:commercecart/common/widgets/custom_button.dart';
import 'package:commercecart/common/widgets/stars.dart';
import 'package:commercecart/constants/globals.dart';
import 'package:commercecart/features/search/screens/search_screen.dart';
import 'package:commercecart/models/product.dart';
import 'package:commercecart/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:badges/badges.dart' as badges;

class ProductDetailScreen extends StatefulWidget {
  static const String routeName = '/product/detail';
  final Product product;
  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  final AppSharedPreference preference = AppSharedPreference();
  int _counter = 0;
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    if (_counter > 0) {
      setState(() {
        _counter--;
      });
    }
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
                  ),
                  const badges.Badge(
                    badgeContent: Text('3'),
                    badgeStyle: badges.BadgeStyle(badgeColor: Colors.white),
                    child: Icon(Icons.shopping_cart_outlined),
                  ),
                ],
              )),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.product.id!),
                    const Stars(rating: 4),
                  ],
                ),
                const SizedBox(height: 10),
                CarouselSlider(
                    items: widget.product.images
                        .map((i) => Builder(
                              builder: (context) {
                                return Image.network(
                                  i,
                                  fit: BoxFit.contain,
                                  height: 200,
                                );
                              },
                            ))
                        .toList(),
                    options: CarouselOptions(
                        viewportFraction: 1,
                        height: 300,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _current = index;
                          });
                        })),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: widget.product.images.asMap().entries.map((entry) {
                    return GestureDetector(
                      onTap: () => _controller.animateToPage(entry.key),
                      child: Container(
                        width: 8.0,
                        height: 8.0,
                        margin: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 4.0),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:
                                (Theme.of(context).brightness == Brightness.dark
                                        ? Colors.white
                                        : Colors.black)
                                    .withOpacity(
                                        _current == entry.key ? 0.9 : 0.4)),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),
                Text(
                  widget.product.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                RichText(
                    text: TextSpan(
                        text: '',
                        style:
                            const TextStyle(color: Colors.black, fontSize: 15),
                        children: [
                      TextSpan(
                        text: '\$ ${widget.product.price.toDouble()}  ',
                        style: const TextStyle(
                            color: Colors.red,
                            fontSize: 22,
                            fontWeight: FontWeight.w700),
                      ),
                      TextSpan(
                        text: '\$ ${(widget.product.price + 200).toDouble()}',
                        style: const TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey,
                            fontStyle: FontStyle.normal,
                            fontSize: 20,
                            fontWeight: FontWeight.w700),
                      )
                    ])),
                const SizedBox(height: 10),
                Text(widget.product.description),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Card(
                      elevation: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.add,
                              size: 18,
                            ),
                            onPressed: _incrementCounter,
                          ),
                          Text(
                            '$_counter',
                            style: const TextStyle(fontSize: 18.0),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.remove,
                              size: 18,
                            ),
                            onPressed: _decrementCounter,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomButton(
                          onPressed: () {}, text: const Text('Add to Cart')),
                    )),
                  ],
                ),
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    'Rate the Product',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                RatingBar.builder(
                  initialRating: 0,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4),
                  itemBuilder: (context, index) {
                    return Icon(
                      Icons.star,
                      color: Globals.secondaryColor,
                    );
                  },
                  onRatingUpdate: (value) {},
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar:
            CustomButton(onPressed: () {}, text: const Text('Buy Now')));
  }
}
