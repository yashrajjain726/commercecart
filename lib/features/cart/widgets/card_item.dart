import 'package:commercecart/common/widgets/stars.dart';
import 'package:commercecart/constants/globals.dart';
import 'package:commercecart/features/cart/services/cart_services.dart';
import 'package:commercecart/features/product/screens/product_detail_screen.dart';
import 'package:commercecart/features/product/services/product_detail_service.dart';
import 'package:commercecart/models/product.dart';
import 'package:commercecart/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartItem extends StatefulWidget {
  final int index;
  const CartItem({super.key, required this.index});

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  final ProductDetailService productDetailService = ProductDetailService();
  final CartServices cartServices = CartServices();
  @override
  Widget build(BuildContext context) {
    final product = context.watch<UserProvider>().user.cartList[widget.index];
    final productMap = Product.fromMap(product['product']);
    final quantity = product['quantity'];
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, ProductDetailScreen.routeName,
          arguments: productMap),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  productMap.images[0],
                  fit: BoxFit.contain,
                  height: 135,
                  width: 135,
                ),
                const SizedBox(width: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 235,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        productMap.name,
                        style: const TextStyle(fontSize: 18),
                        maxLines: 2,
                      ),
                    ),
                    Container(
                      width: 235,
                      padding: const EdgeInsets.only(left: 10, top: 5),
                      child: Text(
                        '\$ ${productMap.price}',
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                        maxLines: 2,
                      ),
                    ),
                    Container(
                      width: 235,
                      padding: const EdgeInsets.only(left: 10),
                      child: const Text(
                        'Eligible for FREE shipping',
                      ),
                    ),
                    Container(
                      width: 235,
                      padding: const EdgeInsets.only(left: 10, top: 5),
                      child: const Text(
                        'In Stock',
                        style: TextStyle(
                            color: Globals.secondaryColor,
                            fontWeight: FontWeight.bold),
                        maxLines: 2,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove, size: 18),
                          onPressed: () {
                            cartServices.removeProductfromCart(
                                context: context, productId: productMap.id!);
                          },
                        ),
                        Text(
                          '$quantity',
                          style: const TextStyle(fontSize: 18.0),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add, size: 18),
                          onPressed: () {
                            productDetailService.addProductToCart(
                                context: context, productId: productMap.id!);
                          },
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}
