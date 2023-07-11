import 'package:carousel_slider/carousel_slider.dart';
import 'package:commercecart/common/widgets/appbar_search_widget.dart';
import 'package:commercecart/common/widgets/custom_button.dart';
import 'package:commercecart/common/widgets/dotted_carousel.dart';
import 'package:commercecart/common/widgets/stars.dart';
import 'package:commercecart/constants/globals.dart';
import 'package:commercecart/constants/utils.dart';
import 'package:commercecart/features/cart/screens/cart_screen.dart';
import 'package:commercecart/features/search/screens/search_screen.dart';
import 'package:commercecart/models/product.dart';
import 'package:commercecart/providers/user_provider.dart';
import 'package:commercecart/services/user_service.dart';
import 'package:commercecart/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatefulWidget {
  static const String routeName = '/product/detail';
  final Product product;
  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final AppSharedPreference preference = AppSharedPreference();
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;
  final UserService userService = UserService();
  double avgRating = 0;
  double myRating = 0;

  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  void initState() {
    super.initState();
    final userProvider = context.read<UserProvider>();

    double totatRating = 0;
    for (int i = 0; i < widget.product.rating!.length; i++) {
      if (widget.product.rating![i].userId == userProvider.user.id) {
        myRating = widget.product.rating![i].rating;
      }
      totatRating += widget.product.rating![i].rating;
    }
    if (totatRating != 0) {
      avgRating = totatRating / (widget.product.rating!.length);
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
              title: const AppBarSearchWidget(
                showCartButton: true,
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
                    Stars(rating: avgRating),
                  ],
                ),
                const SizedBox(height: 10),
                DottedCarousel(images: widget.product.images),
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Rate the product',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      RatingBar.builder(
                        initialRating: myRating,
                        minRating: 1,
                        itemSize: 20,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding: const EdgeInsets.symmetric(horizontal: 0),
                        itemBuilder: (context, index) {
                          return const Icon(
                            Icons.star,
                            color: Globals.secondaryColor,
                          );
                        },
                        onRatingUpdate: (value) {
                          userService.rateProduct(
                              context: context,
                              product: widget.product,
                              rating: value);
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomButton(
                      onPressed: () {
                        userService.addProductToCart(
                            context: context, productId: widget.product.id!);
                        showSnackbar(
                            context, 'Product added to cart successfully..');
                      },
                      text: const Text('Add to Cart')),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar:
            CustomButton(onPressed: () {}, text: const Text('Buy Now')));
  }
}
