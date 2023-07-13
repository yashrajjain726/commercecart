import 'package:commercecart/constants/globals.dart';
import 'package:commercecart/features/home/services/home_service.dart';
import 'package:commercecart/features/product/screens/product_detail_screen.dart';
import 'package:commercecart/models/product.dart';
import 'package:flutter/material.dart';

class DealOfDayWidget extends StatefulWidget {
  const DealOfDayWidget({super.key});

  @override
  State<DealOfDayWidget> createState() => _DealOfDayWidgetState();
}

class _DealOfDayWidgetState extends State<DealOfDayWidget> {
  final HomeService homeService = HomeService();
  Product? product;
  @override
  void initState() {
    super.initState();
    fetchDealOfDay();
  }

  fetchDealOfDay() async {
    product = await homeService.fetchDealOftheDay(context);
    setState(() {});
  }

  updateMainImage() {}

  @override
  Widget build(BuildContext context) {
    return product == null
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : product!.name.isEmpty
            ? const SizedBox.shrink()
            : Column(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(
                        context, ProductDetailScreen.routeName,
                        arguments: product),
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          padding: const EdgeInsets.only(left: 10, top: 15),
                          child: const Text('Deal of the day',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                              )),
                        ),
                        const SizedBox(height: 10),
                        Image.network(
                          product!.images[0],
                          height: 235,
                          fit: BoxFit.fitHeight,
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              alignment: Alignment.topLeft,
                              padding: const EdgeInsets.only(
                                  left: 15, top: 5, right: 40),
                              child: Text(
                                product!.name,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              padding: const EdgeInsets.only(right: 15),
                              child: Text(
                                '\$ ${product!.price.toDouble()}',
                                style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Container(
                          alignment: Alignment.topLeft,
                          padding: const EdgeInsets.only(
                              left: 15, top: 5, right: 40),
                          child: Text(
                            product!.description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  ),
                  (product!.images.length == 1)
                      ? const SizedBox.shrink()
                      : SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: product!.images
                                .map(
                                  (e) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onTap: updateMainImage,
                                      child: Image.network(
                                        e,
                                        fit: BoxFit.cover,
                                        width: 100,
                                        height: 100,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 15)
                        .copyWith(left: 15),
                    alignment: Alignment.topLeft,
                    child: Text(
                      'See all deals',
                      style: TextStyle(
                          color: Globals.selectedNavBarColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              );
  }
}
